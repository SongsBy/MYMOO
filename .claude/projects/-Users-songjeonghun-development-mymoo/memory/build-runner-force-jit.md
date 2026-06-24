---
name: build-runner-force-jit
description: build_runner fails on this machine unless run with --force-jit (Dart 3.10 build hooks)
metadata:
  type: project
---

이 프로젝트에서 `dart run build_runner build`는 그냥 돌리면 실패한다:
`'dart compile' does not support build hooks, use 'dart build' instead.`

**원인**: Dart SDK 3.10.x의 native-assets `hooks` 시스템 + transitive 의존성 `objective_c`(← path_provider_foundation)가 build hook(`hook/build.dart`)을 선언. build_runner가 빌더 엔트리포인트를 AOT(`dart compile`)로 컴파일하다 거부당함. build_runner의 AOT→JIT 자동 폴백은 `dart:mirrors` 실패에만 동작해서 이 경우엔 폴백 안 되고 하드 실패.

**해결**: 항상 `--force-jit`를 붙여 JIT(kernel) 컴파일로 우회한다.
```bash
dart run build_runner build --delete-conflicting-outputs --force-jit
```
JIT는 빌더 컴파일만 약간 느리고 생성 결과물은 동일.

관련: [[riverpod3-provider-naming]]
