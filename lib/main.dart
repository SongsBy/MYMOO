import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/root_tab/presentation/screens/root_tab_screen.dart';

void main() {
  // Riverpod provider 트리 루트. (@riverpod 사용에 필수)
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mymoo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RootTabScreen(),
    );
  }
}
