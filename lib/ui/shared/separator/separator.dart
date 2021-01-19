import 'package:flutter/widgets.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/size.dart';

class Separator extends StatelessWidget {
  const Separator(
      {Key key, this.height = regularSeparator, this.color = grey_40})
      : super(key: key);

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      width: double.infinity,
    );
  }
}
