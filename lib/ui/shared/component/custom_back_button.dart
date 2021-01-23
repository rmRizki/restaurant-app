import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/size.dart';
import 'package:restaurant_app/utils/styles/text.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back_rounded,
                size: regularIconSize, color: grey_80),
            SizedBox(width: 4.0),
            Text(GlobalString.back, style: bigTitle.copyWith(color: grey_80))
          ],
        ),
      ),
    );
  }
}
