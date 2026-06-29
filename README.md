# mymoo

> 모두의 창업 프로젝트 **마이무** — Flutter 클라이언트(FE)

식당 탐색 · 상세 · QR 결제 · 마이페이지를 제공하는 한국 시장 타겟 프로덕션 앱이다.
백엔드(REST API)는 별도 팀이 담당하며, 이 저장소는 Flutter 클라이언트만 포함한다.

---

## 1. 기술 스택

| 영역 | 사용 기술 |
|---|---|
| 프레임워크 | **Flutter 3.44.0 (stable)** / Dart SDK `^3.10.7` |
| 상태관리 | **Riverpod 3.x** (`flutter_riverpod`, `riverpod_annotation` + `riverpod_generator`) — `@riverpod` 어노테이션 방식 |
| 모델/불변객체 | **freezed** + **json_serializable** |
| 네트워크 | **dio** + **retrofit** (+ dio interceptor) |
| 라우팅 | **go_router** *(의존성 추가됨, 점진 적용 예정)* |
| 보안 저장소 | **flutter_secure_storage** 9.x (토큰 등 민감정보) |
| 로깅 | **logger** |
| 아이콘/이미지 | **flutter_svg** + 커스텀 SVG/PNG 에셋 |
| QR 결제 | **mobile_scanner**(카메라 스캔), **qr_flutter**(내 QR 렌더링), **image_picker**(갤러리 QR), **screen_brightness**(밝기 제어) |
| 폰트 | **Pretendard** (400/500/600/700) |
| 린트 | **flutter_lints** |
| 코드 생성 | **build_runner** (freezed / json_serializable / retrofit / riverpod_generator) |

> ⚠️ `pubspec.yaml`에 `dependency_overrides`로 `path_provider_android`/`path_provider_foundation`를 핀 고정해 둔다.
> 최신 path_provider 구현이 끌어오는 jni/objective_c 네이티브 build hook이 `build_runner`의 `dart compile` 단계와 충돌하기 때문이다. build_runner가 build hook을 지원하면 제거 예정.

---

## 2. 폴더 구조

3레이어(**data / domain / presentation**) 클린 아키텍처를 따른다. 의존성은 항상 안쪽(domain)을 향한다.

```
mymoo/
├── lib/
│   ├── main.dart                       # 앱 엔트리 (ProviderScope + MaterialApp)
│   │
│   ├── core/                           # 앱 전역 인프라 (UI 아님)
│   │   ├── config/
│   │   │   └── app_config.dart         # flavor별 환경변수 / base URL
│   │   ├── constants/
│   │   │   └── app_spacing.dart        # 간격 상수 (xs/sm/md/lg/xl)
│   │   ├── error/
│   │   │   ├── failure.dart            # Failure sealed class
│   │   │   └── dio_error_mapper.dart   # DioException → Failure 변환
│   │   ├── extensions/
│   │   │   └── int_format_x.dart       # 숫자 포맷 등 확장 함수
│   │   ├── network/
│   │   │   ├── dio_provider.dart       # dio 인스턴스 provider
│   │   │   └── auth_interceptor.dart   # 인증 헤더 부착 / 401 갱신
│   │   └── theme/
│   │       ├── app_colors.dart         # 색상 상수
│   │       ├── app_text_styles.dart    # 타이포그래피
│   │       └── app_theme.dart          # ThemeData (MaterialApp.theme)
│   │
│   ├── common/                         # 여러 feature가 공유하는 재사용 UI 위젯
│   │   └── widgets/
│   │       ├── Input_box/              # app_input_box
│   │       ├── app_bar/                # home/detail app bar, action item
│   │       ├── bottom_nav/             # root_bottom_nav
│   │       ├── buttons/                # app / line / pill / sheet button
│   │       ├── chips/                  # category / filter / tag chip
│   │       ├── app_error_view.dart
│   │       └── dot_separator.dart
│   │
│   └── features/                       # 기능 단위 (각각 data/domain/presentation)
│       ├── root_tab/                   # 하단 탭 컨테이너 (탭 인덱스 provider)
│       ├── home/                       # 홈 (잔액 카드, 메뉴, 프로모, 퀵액션)
│       ├── restaurant_finder/          # 식당 찾기 (카테고리 필터 + 검색 + 페이지네이션)
│       ├── restaurant_list/            # 📌 레퍼런스 feature (리스트 + 페이지네이션 전 과정)
│       ├── restaurant_detail/          # 식당 상세 (사진 캐러셀, 리뷰, 주간 식단)
│       ├── qr_payment/                 # QR 결제 (스캔 / 내 QR / 결제 시트)
│       ├── my_restaurant/              # 내 식당
│       └── my_page/                    # 마이페이지 (프로필, 통계, 설정)
│
├── asset/
│   ├── fonts/                          # Pretendard (Regular/Medium/SemiBold/Bold)
│   ├── icons/                          # SVG 아이콘 (LineRounded, arrow, heart, home,
│   │                                   #   map, menu_setting, other_component, search,
│   │                                   #   setting, statistics, user)
│   └── images/home/                    # 홈 화면 이미지 (mymoo_ch.png 등)
│
├── test/
│   └── widget_test.dart
│
├── android/  ios/  web/  macos/  linux/  windows/   # 플랫폼별 네이티브 프로젝트
│
├── pubspec.yaml
├── analysis_options.yaml
├── CLAUDE.md                           # 코딩 규칙·아키텍처 기준 문서 (작업 전 필독)
└── README.md
```

### feature 내부 구조 (레이어)

각 feature는 아래 3레이어로 구성한다. (레퍼런스: `lib/features/restaurant_list/`)

```
features/<feature_name>/
├── data/
│   ├── models/         # *_model.dart (freezed + json), API JSON ↔ model 변환
│   ├── datasources/    # retrofit API 정의 (+ 현재는 *_dummy_data.dart 임시 사용)
│   └── repositories/   # repository 구현체 (*_repository_impl.dart)
├── domain/
│   ├── entities/       # 순수 도메인 객체 (선택)
│   └── repositories/   # repository 추상 클래스 (interface)
└── presentation/
    ├── providers/      # @riverpod notifier / provider
    ├── screens/        # *_screen.dart
    └── widgets/        # 이 feature 전용 위젯
```

> 의존성 방향: `presentation → domain ← data`.
> domain은 dio/retrofit/Flutter 위젯을 import 하지 않는 순수 Dart다.

---



## 3. 시작하기

### 사전 요구사항
- Flutter **3.44.0 (stable)** 고정
- iOS 빌드: Xcode + CocoaPods (`cd ios && pod install`)

### 설치 및 코드 생성

```bash
# 1) 의존성 설치
flutter pub get

# 2) 코드 생성 (freezed / json / retrofit / riverpod)
#    모델·provider·retrofit을 추가/수정했다면 반드시 실행
dart run build_runner build --delete-conflicting-outputs
```

### 실행

```bash
# 현재 엔트리는 lib/main.dart 단일 진입
flutter run
```


---

## 4. 자주 쓰는 명령어

```bash
# 의존성 설치
flutter pub get

# 코드 생성 (모델/provider/retrofit 변경 후)
dart run build_runner build --delete-conflicting-outputs

# 코드 생성 watch 모드 (개발 중 자동 재생성)
dart run build_runner watch --delete-conflicting-outputs

# 정적 분석 / 포맷 / 테스트
flutter analyze
dart format .
flutter test

# 실행
flutter run

# 릴리스 빌드 (Android, 난독화 포함 예시)
flutter build appbundle --obfuscate --split-debug-info=build/symbols
```

---

## 5. 주요 기능(feature)

| feature | 설명 |
|---|---|
| `root_tab` | 하단 네비게이션 + 탭 컨테이너 (탭 인덱스 provider 관리) |
| `home` | 홈 화면 — 잔액 카드, 메뉴 카드, 프로모 배너, 퀵 액션, 사용자 인사 |
| `restaurant_finder` | 식당 찾기 — 카테고리 필터 바 + 검색 바 + 요약 카드 리스트(페이지네이션) |
| `restaurant_list` | 📌 **레퍼런스 feature** — 리스트 + 페이지네이션 전 과정 구현 예시 |
| `restaurant_detail` | 식당 상세 — 사진 캐러셀, 헤더, 리뷰 섹션, 주간 식단 |
| `qr_payment` | QR 결제 — 카메라 스캔 오버레이, 내 QR 코드, 결제 액션 시트 |
| `my_restaurant` | 내 식당 화면 |
| `my_page` | 마이페이지 — 프로필 카드, 통계 카드, 설정(섹션/행/토글) |

---

## 6. 백엔드 합의 필요 항목

아래는 임의로 정하지 않고 백엔드 팀과 합의 후 확정한다 (현재는 기본 구현/더미만).

- 에러 응답 JSON 포맷 (`Failure` 파싱 기준)
- 토큰 스펙 (JWT 여부, 만료, refresh 엔드포인트)
- 페이지네이션 방식 (offset / cursor)
- 강제 업데이트(force update) · 점검 모드(maintenance) API
</content>
</invoke>
