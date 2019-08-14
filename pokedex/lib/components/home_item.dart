import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class HomeItem extends StatelessWidget {
  final String text;
  final Color color;
  final Color text_color;
  const HomeItem({
    Key key,
    this.text,
    this.color = Colors.black87,
    this.text_color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border = BorderRadius.all(new Radius.circular(10.0));
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: border),
      child: Stack(
        children: <Widget>[
          Transform.scale(
            scale: 0.85,
            child: Transform.translate(
              offset: Offset(55, 0),
              child: Transform.rotate(
                child: SvgPicture.asset(
                  'assets/logos/pokeball.svg',
                  color: Color(0x30FFFFFF),
                  alignment: Alignment.center,
                ),
                angle: math.pi / 4,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 14),
            child: Text(
              text,
              style: TextStyle(color: text_color, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
