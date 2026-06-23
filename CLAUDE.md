# CLAUDE.md

이 문서는 이 프로젝트에서 코드를 작성·수정하는 모든 작업의 **절대 기준**이다.
LLM(Claude 등)은 코드를 생성하기 전에 이 문서의 규칙을 먼저 따른다.
여기 적힌 규칙과 충돌하는 코드는 작성하지 않는다.

> 📌 **새 feature를 만들 때는 `lib/features/restaurant_list/`를 레퍼런스로 삼아 동일한 구조·패턴으로 작성한다.**
> 그 폴더가 이 문서 규칙의 "살아있는 예시"다. 구체적인 코드 패턴은 문서가 아니라 그 폴더를 참고한다.

---

## 0. 프로젝트 개요

- **앱 종류**: 실제 스토어 출시를 목표로 하는 프로덕션 앱 (토이 프로젝트 아님)
- **타겟 시장**: 한국 (현재 다국어 미지원, 추후 확장 가능성만 열어둠)
- **Flutter 개발자**: 1인
- **백엔드**: 별도 팀원이 직접 개발 (REST API). Flutter는 클라이언트만 담당.
- **Flutter 버전**: **3.44.0 (stable) 고정**. 이 버전 기준 문법만 사용한다.
- **Dart 버전**: Flutter 3.44.0에 포함된 Dart SDK 버전을 따른다.

> ⚠️ 버전 혼용 금지: 구버전 문법이나 deprecated API를 섞지 않는다.
> 특히 Riverpod은 아래 명시된 3.x 어노테이션 방식만 쓴다.

---

## 1. 기술 스택 (고정)

| 영역 | 사용 기술 | 비고 |
|---|---|---|
| 상태관리 | **Riverpod 3.x** + `@riverpod` 어노테이션 (riverpod_generator) | Provider, StateNotifier 직접 사용 금지 |
| 모델/불변객체 | **freezed** + **json_serializable** | 모든 model/state는 freezed로 |
| 네트워크 | **dio** + **retrofit** + **dio interceptor** | REST 통신 |
| 라우팅 | **go_router** | redirect로 인증 가드 처리 |
| 보안 저장소 | **flutter_secure_storage** | 토큰 등 민감정보 전용 |
| 로깅 | **logger** 패키지 | prod에서 `print` 금지 |
| 크래시/분석 | **Firebase Crashlytics** + **Firebase Analytics** | 출시 운영 필수 |
| 린트 | `flutter_lints` (또는 `very_good_analysis`) | analysis_options.yaml에 강제 |

### 금지 패키지/패턴
- ❌ `provider` 패키지 (Riverpod로 통일)
- ❌ `StateNotifier` / `ChangeNotifier` 직접 사용 (`@riverpod` Notifier/AsyncNotifier로)
- ❌ 토큰을 `SharedPreferences`에 저장 (반드시 `flutter_secure_storage`)
- ❌ 페이지네이션용 외부 패키지(`riverpod_infinite_scroll` 등) — 직접 구현한다 (§7 참고)

---

## 2. 폴더 구조

```
lib/
├── main.dart                 # 공통 부트스트랩 (각 flavor main에서 호출)
├── main_dev.dart
├── main_staging.dart
├── main_prod.dart
│
├── core/                     # 앱 전역 인프라 (UI 아님)
│   ├── config/               # AppConfig (flavor별 환경변수, base URL)
│   ├── network/              # dio 인스턴스, interceptor, retrofit 베이스
│   ├── router/               # go_router 설정, redirect, route 정의
│   ├── theme/                # AppColors, AppTextStyles, AppTheme(ThemeData)
│   ├── error/                # Failure (sealed class), 예외 → Failure 변환
│   ├── constants/            # 앱 전역 상수 (간격 등)
│   ├── storage/              # secure_storage 래퍼
│   └── extensions/           # 공통 확장 함수
│
├── common/                   # 재사용 UI 위젯 (여러 feature에서 공유)
│   └── widgets/              # AppButton, AppTextField, AppCard, 로딩/에러 위젯 등
│
└── features/                 # 기능 단위
    └── <feature_name>/       # 이름은 항상 snake_case
        ├── data/
        │   ├── models/       # *_model.dart (freezed + json)
        │   ├── datasources/  # retrofit API 정의
        │   └── repositories/ # repository 구현체 (impl)
        ├── domain/
        │   ├── entities/     # 순수 도메인 객체 (선택, 작은 앱은 model 재사용 가능)
        │   └── repositories/ # repository 추상 클래스 (interface)
        └── presentation/
            ├── providers/    # @riverpod notifier / provider
            ├── screens/      # *_screen.dart
            └── widgets/      # 이 feature 전용 위젯
```

> 레퍼런스 구현: `lib/features/restaurant_list/` (리스트 + 페이지네이션 전 과정 포함)

### 폴더 구조 핵심 규칙
- **`core/` = 인프라, `common/` = 재사용 UI.** 둘을 섞지 않는다.
- **재사용되는 위젯만 `common/`에 둔다.** 한 화면에서만 쓰는 위젯은 그 feature의 `presentation/widgets/`에.
- **feature 안은 항상 data / domain / presentation 3레이어.**
- 폴더·파일명은 **snake_case** (예: `restaurant_list_screen.dart`).
- 클래스명은 **PascalCase** (예: `RestaurantListScreen`).

---

## 3. 아키텍처 규칙 (의존성 방향)

이 프로젝트는 **3레이어 (data / domain / presentation)** 구조를 따른다.
의존성은 **항상 안쪽(domain)을 향한다.**

```
presentation  →  domain  ←  data
   (UI)         (추상)      (구현)
```

### 절대 규칙 (DO NOT)
- ❌ **domain 레이어에서 dio / retrofit / Flutter 위젯을 import 하지 않는다.** domain은 순수 Dart만.
- ❌ **presentation에서 dio를 직접 호출하지 않는다.** 반드시 repository(provider 경유)를 통한다.
- ❌ **위젯(build 메서드) 안에 비즈니스 로직을 작성하지 않는다.** 로직은 provider/notifier로.
- ❌ **repository 구현체를 presentation에서 직접 new 하지 않는다.** Riverpod provider로 주입한다.

### DO
- ✅ repository는 **domain에 추상 클래스(interface)**, **data에 구현체(Impl)** 로 분리한다.
- ✅ API 응답(JSON) ↔ model 변환은 **data 레이어 model**에서만 한다.
- ✅ 비동기 상태는 **`AsyncValue`** 로 다룬다 (§5 참고).

---

## 4. 디자인 시스템 (테마/색상/폰트)

**모든 색상·폰트·간격은 상수/테마로 정의하고 재사용한다. 하드코딩 절대 금지.**

- **색상**: `core/theme/app_colors.dart`에 상수로 정의. 위젯에서 `Color(0xFF...)` 직접 사용 ❌ → `AppColors.primary` ✅.
- **타이포그래피**: `core/theme/app_text_styles.dart`에 헤더/본문/캡션 등 정의. `TextStyle(...)` 직접 작성 ❌ → `AppTextStyles.headline1` ✅.
- **ThemeData**: `core/theme/app_theme.dart`에서 위를 묶어 구성하고 `MaterialApp.theme`에 연결.
- **간격**: 매직 넘버 대신 `core/constants/app_spacing.dart`에 `xs/sm/md/lg/xl` 등으로 정의.

색상·폰트 값은 Figma 디자인에서 추출해 채운다.

---

## 5. 에러 처리 전략

**`Failure` sealed class + `AsyncValue.when` 조합으로 통일한다.**
(Either/dartz는 사용하지 않는다 — Riverpod의 AsyncValue와 패러다임이 겹쳐 복잡해지므로.)

### 흐름
1. **dio interceptor**: 공통 처리 (인증 헤더 부착, 401 토큰 갱신 등).
2. **repository**: `DioException` 등 예외를 의미 있는 **`Failure`** 로 변환해 throw.
3. **presentation**: `@riverpod` AsyncNotifier가 자동으로 `AsyncError`로 잡음 → `.when(data:, loading:, error:)` 로 UI 분기.

### 규칙
- `Failure`는 `core/error/failure.dart`에 freezed sealed class로 정의 (network / server / unauthorized / notFound / unknown 등).
- `DioException → Failure` 변환 함수를 `core/error/`에 두고 **모든 repository가 재사용**한다.
- 화면마다 try-catch를 제각각 작성하지 않는다.

> ⚠️ 에러 응답 포맷(서버가 주는 에러 JSON 구조)은 **백엔드 팀원과 합의 필요**.
> 합의 전까지는 기본 Failure로 구현하고, 확정되면 server 에러 파싱을 맞춘다.

> 구현 예시: `lib/core/error/` 와 `restaurant_list/data/repositories/` 참고.

---

## 6. 네트워크 / 인증

### dio + retrofit
- `core/network/`에 dio 인스턴스와 retrofit 베이스를 둔다.
- API 정의는 각 feature의 `data/datasources/`에 retrofit 인터페이스로.

### 인증 플로우 (interceptor)
- **access token / refresh token 분리** 저장 (둘 다 `flutter_secure_storage`).
- 요청 시 interceptor가 access token을 헤더에 부착.
- **401 응답** → interceptor가 refresh token으로 access token 자동 갱신 → 원요청 재시도.
- **refresh도 만료/실패** → 토큰 삭제 + 로그아웃 → go_router redirect로 로그인 화면 이동.

```
요청 → [interceptor: access token 부착] → 서버
401 → [interceptor: refresh 시도] → 성공 시 원요청 재시도
                                   → 실패 시 로그아웃 + /login 으로 redirect
```

> ⚠️ 토큰 형식(JWT 여부, 만료 시간, refresh 엔드포인트 스펙)은 **백엔드 팀원과 합의 필요**.

### go_router 인증 가드
- `core/router/`에서 로그인 상태(provider)를 watch해 `redirect`로 보호 라우트를 막는다.
- 미인증 사용자가 보호 화면 접근 시 `/login`으로, 인증 후 원래 가려던 곳으로.

### 보안 규칙 (DO NOT)
- ❌ 토큰·비밀번호 등 민감정보를 로그로 출력하지 않는다.
- ❌ API 키/시크릿을 코드에 하드코딩하지 않는다 (§8 환경설정으로 주입).
- ❌ 민감정보를 `SharedPreferences`/평문 파일에 저장하지 않는다.

---

## 7. 페이지네이션 (직접 구현)

**리스트성 화면은 페이지네이션을 강제한다.** 전체 데이터를 한 번에 불러오지 않는다.
외부 패키지 없이 **`@riverpod` AsyncNotifier로 직접 구현**한다.

### 필수 요구사항
- **첫 페이지 로딩**과 **다음 페이지 로딩** 상태를 분리한다.
  - 첫 로딩: 전체 화면 스피너 / 스켈레톤.
  - 다음 페이지: 리스트 **하단**에 작은 인디케이터.
- **에러 상태도 분리**한다 (첫 페이지 에러 = 전체 재시도 / 다음 페이지 에러 = 하단 재시도).
- **pull-to-refresh** (당겨서 새로고침) 지원 → 전체 데이터 리로드.
- **중복 요청 방지**: 같은 페이지를 두 번 부르지 않도록 가드. 진행 중이면 추가 요청 무시.
- **CancelToken** 사용: 빠른 스크롤 등으로 불필요해진 in-flight 요청은 dio CancelToken으로 취소.
- 페이지 키 타입은 백엔드 방식에 맞춘다 (offset=int / cursor=String·DateTime 등). **백엔드와 합의 필요.**
- 스크롤 끝 감지: `ScrollController`의 `maxScrollExtent` 근처 도달 시 다음 페이지 로드.

> 구현 패턴은 `lib/features/restaurant_list/`를 **그대로 복사**해서 사용한다.
> 새 리스트 feature는 위 요구사항 7가지를 모두 갖춰야 한다.

---

## 8. 환경 설정 (flavor)

**dev / staging / prod 3개 환경**을 분리한다. (출시 앱이므로 처음부터 분리)

- 각 환경별 entry: `main_dev.dart`, `main_staging.dart`, `main_prod.dart`.
- 환경 변수(base URL 등)는 `--dart-define-from-file`로 주입하고 `AppConfig`에서 읽는다.
- **base URL은 `AppConfig`에서만 가져온다.** 코드 어디에도 URL 하드코딩 금지.
- 앱 아이콘 / 앱 이름 / 번들 ID는 flavor별로 분리 (개발자 기기에 dev/prod 동시 설치 가능).

실행 예:
```bash
flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=config/dev.json
```

> ⚠️ `config/*.json` (실제 URL/키 포함)은 `.gitignore`에 넣고, 예시용 `config/*.example.json`만 커밋한다.

---

## 9. 코드 생성 (build_runner) — 중요

freezed / json_serializable / retrofit / riverpod_generator 는 모두 코드 생성이 필요하다.

### 절대 규칙
- ❌ **`*.g.dart`, `*.freezed.dart` 파일을 직접 수정하지 않는다.** (생성 파일)
- ⚠️ **코드 생성이 필요한 변경(모델·provider·retrofit 추가/수정)을 한 경우, 직접 build_runner를 돌리지 말고 사용자에게 "지금 build_runner를 돌려야 한다"고 알린다.** generator 실행은 사용자가 한다.

알려야 하는 명령어:
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 10. 관측(Observability) — 1인 개발 필수

출시 후 혼자 운영하므로, 무슨 일이 일어나는지 볼 수 있어야 한다.

- **Crashlytics**: 앱 시작 시 초기화. `FlutterError.onError` / `PlatformDispatcher.instance.onError`에 연결해 잡히지 않은 에러를 자동 보고.
- **로깅**: `logger` 패키지 사용, 레벨(debug/info/warning/error) 구분. prod 빌드에서 `print` 금지.
- **분석(Analytics)**: 핵심 사용자 행동(주요 화면 진입, 핵심 액션)에 이벤트 로깅. 과하지 않게 시작.

---

## 11. 출시 전 체크리스트 (자리만 잡아둠 — 기능 확정 시 구현)

프로덕션 앱에 필요하지만 백엔드/기획 확정이 필요한 항목. 코드 자리만 마련해 둔다.

- [ ] **강제 업데이트 (force update)**: 시작 시 최소 지원 버전을 서버에서 받아 미만이면 안내 화면. *(백엔드 합의)*
- [ ] **점검 모드 (maintenance)**: 서버 점검 시 차단 화면. *(백엔드 합의)*
- [ ] **푸시 알림 (FCM)**: 기능 요구사항 확정 후.
- [ ] **개인정보 처리방침 / 이용약관**: 스토어 등록 필수. 앱 내 링크.
- [ ] **iOS ATT**: 분석/광고 SDK 사용 시 Apple 심사 대응.
- [ ] **스토어 데이터 수집 고지**: App Store '개인정보 보호 정보', Play '데이터 보안'.
- [ ] **앱 아이콘 / 스플래시 / 런치스크린**: flavor별.
- [ ] **코드 난독화**: 릴리스 빌드 시 `--obfuscate --split-debug-info`.

---

## 12. 테스트

1인 개발이라 풀 커버리지는 무리지만, **핵심 로직만큼은 단위 테스트를 둔다.**

- repository 변환 로직 / Failure 매핑.
- notifier(AsyncNotifier)의 페이지네이션 로직 (다음 페이지, 끝 처리, 에러).
- 위젯 테스트는 핵심 화면 위주로 선택적.

---

## 13. 명령어 모음

```bash
# 의존성 설치
flutter pub get

# 코드 생성 (모델/provider/retrofit 변경 후 — 사용자가 실행)
dart run build_runner build --delete-conflicting-outputs

# 정적 분석 / 포맷 / 테스트
flutter analyze
dart format .
flutter test

# 실행 (dev flavor)
flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=config/dev.json

# 릴리스 빌드 (prod, 난독화 포함)
flutter build appbundle --flavor prod -t lib/main_prod.dart \
  --dart-define-from-file=config/prod.json \
  --obfuscate --split-debug-info=build/symbols
```

---

## 14. LLM 작업 시 핵심 요약 (이것만은 반드시)

1. **반복 코드 금지.** 재사용 UI는 `common/widgets/`, 인프라는 `core/`에 한 번만 만들고 재사용한다.
2. **하드코딩 금지.** 색상→`AppColors`, 텍스트스타일→`AppTextStyles`, URL→`AppConfig`, 문자열도 상수화 권장.
3. **의존성 방향 지킨다.** domain은 dio/Flutter 모름. presentation은 repository(provider) 경유.
4. **상태관리는 Riverpod 3.x `@riverpod` 어노테이션만.** Provider/StateNotifier 금지.
5. **모델/상태는 freezed.** 에러는 `Failure` + `AsyncValue.when`.
6. **리스트는 페이지네이션 직접 구현** (§7, `restaurant_list` 복사).
7. **토큰은 `flutter_secure_storage`.** 민감정보 로깅·하드코딩 금지.
8. **코드 생성이 필요하면 직접 돌리지 말고 사용자에게 알린다.** 생성 파일 수정 금지.
9. **새 feature는 `lib/features/restaurant_list/` 구조를 그대로 따른다.**
10. **백엔드 의존 항목**(에러 포맷, 토큰 스펙, 페이지네이션 방식, force update/점검 API)은 임의로 정하지 말고 "백엔드 팀원과 합의 필요"로 표시하고 기본 구현만 둔다.
