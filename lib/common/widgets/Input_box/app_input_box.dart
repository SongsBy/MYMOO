import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 메뉴 등록용 Input Box.
///
/// 하나의 위젯이 포커스·입력 상태에 따라 3가지 모습을 자동으로 표현한다.
/// (Figma의 Default / Activation / Completion 상태)
/// - **Default**(등록 이전): 빈 값 + 비포커스 → 회색 테두리, 플레이스홀더(textDisable).
/// - **Activation**(선택/입력 중): 포커스 → 주황(brandPrimary) 테두리.
/// - **Completion**(등록 완료): 값 있음 → 우측 clear 아이콘(ic_searchoff) 노출.
///
/// 공통 스펙: 배경 bgInverse / radius 8 / 16px Medium 텍스트.
class AppInputBox extends StatefulWidget {
  const AppInputBox({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = '메뉴를 등록하세요',
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
  });

  /// 텍스트 컨트롤러. 미지정 시 내부에서 생성·관리한다.
  final TextEditingController? controller;

  /// 포커스 노드. 미지정 시 내부에서 생성·관리한다.
  final FocusNode? focusNode;

  /// 플레이스홀더 텍스트(Default 상태).
  final String hintText;

  /// 텍스트 변경 콜백.
  final ValueChanged<String>? onChanged;

  /// 검색/등록 실행 콜백.
  final ValueChanged<String>? onSubmitted;

  /// 자동 포커스 여부.
  final bool autofocus;

  @override
  State<AppInputBox> createState() => _AppInputBoxState();
}

class _AppInputBoxState extends State<AppInputBox> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _ownsController = widget.controller == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _ownsFocusNode = widget.focusNode == null;

    // 테두리 색(포커스)·clear 아이콘(텍스트 유무) 갱신을 위해 재빌드.
    _controller.addListener(_onChanged);
    _focusNode.addListener(_onChanged);
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _focusNode.removeListener(_onChanged);
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.isNotEmpty;
    final borderColor =
        _focusNode.hasFocus ? AppColors.brandPrimary : AppColors.borderPrimary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgInverse,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: AppTextStyles.body2Medium,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.body2Medium.copyWith(
                  color: AppColors.textDisable,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
          if (hasText) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onChanged?.call('');
              },
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.asset(
                'asset/icons/search/ic_searchoff.svg',
                width: 16.8,
                height: 16.8,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
