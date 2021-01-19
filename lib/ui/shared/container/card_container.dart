import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/styles/decoration.dart';

class CardContainer extends StatelessWidget {
  final Decoration decoration;
  final Function onPressed;
  final Widget child;
  final EdgeInsetsGeometry padding;

  CardContainer({
    this.decoration,
    this.onPressed,
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: decoration ?? BaseDecoration.cardDecoration,
        child: child,
      ),
    );
  }
}
