import 'package:flutter/material.dart';
import 'package:restaurant_app/core/models/restaurant/restaurant_response.dart';
import 'package:restaurant_app/utils/styles/size.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail';

  final Restaurants restaurants;

  DetailScreen({this.restaurants});

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
        background: Image.network(
          restaurants.pictureId,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildList() {
    return SliverList(
      delegate: SliverChildListDelegate([Text(restaurants.name)]),
    );
  }
}
