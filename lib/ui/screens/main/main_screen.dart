import 'package:flutter/material.dart';
import 'package:restaurant_app/core/models/restaurant/restaurant_response.dart';
import 'package:restaurant_app/ui/screens/detail/detail_screen.dart';
import 'package:restaurant_app/utils/file_helper.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/size.dart';

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
    setState(() {
      _restaurantList = rs.restaurants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          _buildAppBar(),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 220.0,
      elevation: softElevation,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(GlobalString.title),
        background: Image.network(
          'https://images.unsplash.com/photo-1516685018646-549198525c1b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildListItem(index);
        },
        childCount: _restaurantList.length,
      ),
    );
  }

  Widget _buildListItem(index) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailScreen.routeName,
        arguments: _restaurantList[index],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          _restaurantList[index].name,
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}
