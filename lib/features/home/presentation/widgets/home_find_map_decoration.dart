import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// "밥 집 찾기" 카드 하단의 지도 일러스트.
///
/// [HomeMenuCard.decoration] 에 주입해 카드 안에 클리핑되어 배치된다.
/// Figma node 69379:1284~1288.
class HomeFindMapDecoration extends StatelessWidget {
  const HomeFindMapDecoration({super.key});

  static const String _line1 = 'asset/images/home/find_map_line1.svg';
  static const String _line2 = 'asset/images/home/find_map_line2.svg';
  static const String _pin1 = 'asset/images/home/find_map_pin1.svg';
  static const String _pin2 = 'asset/images/home/find_map_pin2.svg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 72,
          child: SvgPicture.asset(_line1, fit: BoxFit.fill, height: 17),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 107,
          child: SvgPicture.asset(_line2, fit: BoxFit.fill, height: 78),
        ),
        const Positioned(left: 24, top: 96, child: _MapPin()),
      ],
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 44,
      child: Stack(
        children: [
          SvgPicture.asset(
            HomeFindMapDecoration._pin1,
            fit: BoxFit.fill,
            width: 32,
            height: 44,
          ),
          Positioned(
            left: 7,
            top: 6,
            child: SvgPicture.asset(
              HomeFindMapDecoration._pin2,
              width: 18,
              height: 18,
            ),
          ),
        ],
      ),
    );
  }
}
