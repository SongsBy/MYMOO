import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// 설정 행에서 쓰는 알약형 토글 스위치.
///
/// 디자인 스펙: 트랙 48×28, 썸 22×22, 켜짐=브랜드 그린 / 꺼짐=연회색.
/// 현재는 백엔드 연동 전이라 탭하면 자체 상태만 바뀐다.
/// (설정 저장 API 확정 시 [value]/[onChanged] 를 외부 provider 와 연결한다.)
class SettingsToggle extends StatefulWidget {
  const SettingsToggle({
    super.key,
    required this.initialValue,
    this.onChanged,
  });

  /// 초기 켜짐 여부.
  final bool initialValue;

  /// 값이 바뀔 때 알림(선택).
  final ValueChanged<bool>? onChanged;

  @override
  State<SettingsToggle> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<SettingsToggle> {
  late bool _value = widget.initialValue;

  void _toggle() {
    setState(() => _value = !_value);
    widget.onChanged?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        width: 48,
        height: 28,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: _value ? AppColors.accentGreen : AppColors.borderTertiary,
          borderRadius: BorderRadius.circular(28),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          alignment: _value ? Alignment.centerRight : Alignment.centerLeft,
          child: const SizedBox(
            width: 22,
            height: 22,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.bgInverse,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.opacity20,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
