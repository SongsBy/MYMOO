import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import 'app_button.dart';

/// 바텀시트/화면 하단 CTA 바.
///
/// Figma "Sheet Button" 구현. 두 가지 변형:
/// - **icon and btn**: 좌측 하트(아이콘) 버튼 + 우측 메인 버튼.
///   ([onIconTap]을 지정하면 이 변형으로 그려진다)
/// - **full**: 메인 버튼만 가로로 꽉 채움. ([onIconTap]이 null)
///
/// 스펙: 흰 배경 / padding h20·v12 / 자식 간격 12.
/// 메인 버튼은 [AppButton](brandPrimary, radius 16, padding h16·v13)을 재사용.
///
/// 하단 세이프에어리어가 필요한 화면 푸터로 쓸 때는 호출부에서
/// `SafeArea(top: false, child: SheetButton(...))` 로 감싼다.
class SheetButton extends StatelessWidget {
  const SheetButton({
    super.key,
    required this.label,
    this.onPressed,
    this.onIconTap,
    this.iconSelected = false,
  });

  /// 메인 버튼 라벨.
  final String label;

  /// 메인 버튼 탭 콜백. null 이면 비활성.
  final VoidCallback? onPressed;

  /// 좌측 하트 버튼 탭 콜백. null 이면 하트 버튼을 숨김(full 변형).
  final VoidCallback? onIconTap;

  /// 좌측 하트(찜) 선택 여부. true 면 채워진 하트(brand 색)로 표시한다.
  final bool iconSelected;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.bgInverse,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            if (onIconTap != null) ...[
              _HeartIconButton(onTap: onIconTap!, selected: iconSelected),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: AppButton(
                label: label,
                onPressed: onPressed,
                expanded: true,
                borderRadius: 16,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 51×51 정사각 하트(찜) 아이콘 버튼.
///
/// [selected] 면 채워진 하트(brand 색), 아니면 라인 하트로 그린다.
class _HeartIconButton extends StatelessWidget {
  const _HeartIconButton({required this.onTap, this.selected = false});

  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgInverse,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 51,
          height: 51,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderPrimary),
          ),
          child: SvgPicture.asset(
            selected
                ? 'asset/icons/heart/ic_heartfill.svg'
                : 'asset/icons/heart/ic_heartline.svg',
            width: 24,
            height: 24,
            colorFilter: selected
                ? const ColorFilter.mode(
                    AppColors.brandPrimary,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
