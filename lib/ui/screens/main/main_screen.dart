import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/core/models/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/ui/screens/main/widgets/restaurant_card.dart';
import 'package:restaurant_app/ui/screens/screens.dart';
import 'package:restaurant_app/ui/shared/component/scroll_floating_action_button.dart';
import 'package:restaurant_app/utils/file_helper.dart';
import 'package:restaurant_app/utils/sources/images.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/size.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Restaurants> _restaurantList = [];
  ScrollController _scrollController;

  @override
  void initState() {
    _getRestaurantList();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      floatingActionButton:
          ScrollFloatingActionButton(scrollController: _scrollController),
      backgroundColor: white,
      body: CustomScrollView(
        controller: _scrollController,
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
        background: Image.asset(
          BaseImages.mainImage,
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
    Restaurants restaurant = _restaurantList[index];
    return Container(
      margin: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
      child: RestaurantCard(
        restaurant: restaurant,
        onPressed: () => Navigator.pushNamed(
          context,
          DetailScreen.routeName,
          arguments: restaurant,
        ),
      ),
    );
  }
}
