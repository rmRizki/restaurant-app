import 'dart:convert';

import 'package:flutter/widgets.dart';

Future<dynamic> readJson(BuildContext context, String fileName) async {
  final String response =
      await DefaultAssetBundle.of(context).loadString(fileName);
  final data = await json.decode(response);
  return data;
}
