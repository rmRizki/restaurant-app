import 'package:flutter/material.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/ui/screens/screens.dart';
import 'package:restaurant_app/utils/sources/strings.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreen.routeName:
        return MaterialPageRoute(builder: (_) => MainScreen());
        break;
      case SearchScreen.routeName:
        return MaterialPageRoute(builder: (_) => SearchScreen());
        break;
      case DetailScreen.routeName:
        Restaurants restaurants = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
              restaurant: Restaurant(
            id: restaurants.id,
            name: restaurants.name,
            description: restaurants.description,
            city: restaurants.city,
            rating: restaurants.rating,
            pictureId: restaurants.pictureId,
          )),
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
