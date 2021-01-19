import 'package:flutter/material.dart';
import 'package:restaurant_app/core/models/restaurant/restaurant_response.dart';
import 'package:restaurant_app/ui/screens/screens.dart';
import 'package:restaurant_app/utils/sources/strings.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreen.routeName:
        return MaterialPageRoute(builder: (_) => MainScreen());
        break;
      case DetailScreen.routeName:
        Restaurants restaurants = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(restaurants: restaurants),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text(GlobalString.page_not_found),
              )),
        );
    }
  }
}
