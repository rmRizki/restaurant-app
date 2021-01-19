import 'package:flutter/material.dart';
import 'package:restaurant_app/core/models/restaurant/restaurant_response.dart';
import 'package:restaurant_app/utils/file_helper.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Restaurants> _restaurantList = [];

  @override
  void initState() {
    _getRestaurantList();
    super.initState();
  }

  _getRestaurantList() async {
    final data = await readJson(context, 'assets/local_restaurant.json');
    RestaurantResponse rs = RestaurantResponse.fromJson(data);
    _restaurantList = rs.restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
