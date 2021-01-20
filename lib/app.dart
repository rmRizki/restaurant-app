import 'package:flutter/material.dart';
import 'package:restaurant_app/core/routes/app_route.dart';
import 'package:restaurant_app/ui/screens/screens.dart';
import 'package:restaurant_app/utils/sources/font.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: GlobalString.title,
      theme: ThemeData(
        primaryColor: primary_100,
        fontFamily: FontFamily.monserat,
      ),
      initialRoute: MainScreen.routeName,
      onGenerateRoute: AppRoute.generateRoute,
      navigatorKey: GlobalKey<NavigatorState>(),
    );
  }
}
