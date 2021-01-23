import 'package:flutter/rendering.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/size.dart';

class BaseDecoration {
  static final borderDecoration = BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(smallBorderRadius),
    border: Border.all(
      color: grey_40,
      width: 1,
    ),
  );

  static final cardDecoration = BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(regularBorderRadius),
    border: Border.all(
      color: grey_40,
      width: 0.5,
    ),
  );

  static final cardDecorationShadow = cardDecoration.copyWith(
    boxShadow: [
      BoxShadow(
        color: grey_40,
        offset: Offset(0.0, 1.0), //(x,y)
        blurRadius: softElevation,
      ),
    ],
  );

  static final borderlessCardDecoration = BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(regularBorderRadius),
  );

  static final BoxDecoration bottomBorderDecoration = BoxDecoration(
    color: white,
    border: Border(
      bottom: BorderSide(color: grey_40, width: 1),
    ),
  );

  static final BoxDecoration smallCardDecoration = cardDecoration.copyWith(
    borderRadius: BorderRadius.circular(smallBorderRadius),
  );

  static final shadowDecoration = BoxDecoration(
    color: white,
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        offset: Offset(0.0, 0.0), //(x,y)
        blurRadius: softElevation,
      ),
    ],
  );
  static final circleShadowDecoration = BaseDecoration.shadowDecoration
      .copyWith(borderRadius: BorderRadius.all(Radius.circular(38.0)));
}
