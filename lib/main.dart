import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}
