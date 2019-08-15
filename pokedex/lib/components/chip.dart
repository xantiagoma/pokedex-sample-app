import 'package:flutter/material.dart';

class TypeChip extends StatelessWidget {
  final String text;
  const TypeChip({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        margin: EdgeInsets.only(bottom: 5, left: 5),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.all(new Radius.circular(10.0))),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ));
  }
}
