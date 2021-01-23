import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/decoration.dart';
import 'package:restaurant_app/utils/styles/size.dart';
import 'package:restaurant_app/utils/styles/text.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String hintText;

  const SearchField({
    @required this.controller,
    @required this.onSubmitted,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: Container(
              decoration: BaseDecoration.circleShadowDecoration,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (onChanged != null) onChanged(value);
                  },
                  onSubmitted: (value) {
                    if (onSubmitted != null) onSubmitted(value);
                  },
                  style: paragraphMedium,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(color: grey_60)),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BaseDecoration.circleShadowDecoration,
          child: GestureDetector(
            onTap: () {
              if (onSubmitted != null) onSubmitted(controller.text);
            },
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(Icons.search, size: largerIconSize, color: grey_80),
            ),
          ),
        ),
      ],
    );
  }
}
