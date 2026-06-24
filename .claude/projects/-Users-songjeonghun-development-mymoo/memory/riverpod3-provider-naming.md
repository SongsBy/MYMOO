---
name: riverpod3-provider-naming
description: riverpod_generator 3.x drops the "Notifier" suffix from generated provider names
metadata:
  type: reference
---

riverpod_generator 3.x는 Notifier 클래스명이 `Notifier`로 끝나면 생성되는 provider 변수명에서 **`Notifier` 접미사를 제거**한다.

- 클래스 `RestaurantListNotifier` → provider `restaurantListProvider` (NOT `restaurantListNotifierProvider`)

화면/코드에서 provider를 참조할 때 이 규칙을 따른다. 구버전(2.x) 가정으로 `...NotifierProvider`를 쓰면 `undefined_identifier` 난다.

또한 freezed 3.x는 freezed 클래스를 `abstract class`(단일) 또는 `sealed class`(union)로 선언해야 한다. 그냥 `class`면 concrete 구현 누락 에러.

관련: [[build-runner-force-jit]]
