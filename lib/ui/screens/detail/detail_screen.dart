import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/core/models/restaurant/restaurant_response.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/size.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail';

  final Restaurants restaurant;

  DetailScreen({this.restaurant});

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
      backgroundColor: white,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: '${restaurant.pictureId}',
          child: CachedNetworkImage(
            imageUrl: restaurant.pictureId,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return SliverList(
      delegate: SliverChildListDelegate([Text(restaurant.name)]),
    );
  }
}
