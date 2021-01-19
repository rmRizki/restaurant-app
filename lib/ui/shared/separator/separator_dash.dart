import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/ui/shared/separator/line_dash.dart';
import 'package:restaurant_app/utils/styles/colors.dart';

class SeparatorDash extends StatelessWidget {
  const SeparatorDash({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineDash(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: grey_40,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}
