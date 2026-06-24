import 'package:flutter/material.dart';

/// 화면 전체 에러 상태를 보여주는 공통 위젯.
///
/// 여러 feature 에서 재사용하므로 common/widgets/ 에 둔다.
/// 첫 페이지 로딩 실패(AsyncError) 시 전체 재시도 버튼과 함께 노출한다.
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.onRetry,
    this.message = '문제가 발생했어요.',
  });

  final VoidCallback onRetry;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('다시 시도')),
          ],
        ),
      ),
    );
  }
}
