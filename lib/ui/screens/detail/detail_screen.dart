import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/core/models/restaurant/restaurant_response.dart';
import 'package:restaurant_app/ui/shared/component/scroll_floating_action_button.dart';
import 'package:restaurant_app/ui/shared/separator/separator.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/size.dart';
import 'package:restaurant_app/utils/styles/text.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = 'detail';

  final Restaurants restaurant;

  DetailScreen({this.restaurant});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<String> foods = [];
  List<String> drinks = [];
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    widget.restaurant.menus.foods.forEach((element) {
      foods.add(element.name);
    });
    widget.restaurant.menus.drinks.forEach((element) {
      drinks.add(element.name);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollFloatingActionButton(
        scrollController: _scrollController,
      ),
      body: ListView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          _buildBackButton(context),
          _buildTitle(), // rating, city, description
          _buildMainImage(),
          _buildInfo(
            heading: DetailString.city,
            body: widget.restaurant.city,
            iconData: Icons.location_on_outlined,
          ),
          _buildSeparator(),
          _buildInfo(
            heading: DetailString.rating,
            body: '${widget.restaurant.rating}',
            iconData: Icons.star_border,
          ),
          _buildSeparator(),
          _buildInfo(
            heading: DetailString.totalMenu,
            body:
                '${widget.restaurant.menus.drinks.length + widget.restaurant.menus.foods.length}',
            iconData: Icons.fastfood_outlined,
          ),
          _buildSeparator(),
          _buildDetail(
            heading: DetailString.description,
            body: widget.restaurant.description,
          ),
          _buildDetail(heading: DetailString.food, body: '${foods.join(', ')}'),
          _buildDetail(
              heading: DetailString.drink, body: '${drinks.join(', ')}'),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildBackButton(context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back_rounded,
                size: regularIconSize, color: grey_80),
            SizedBox(width: 4.0),
            Text(GlobalString.back, style: bigTitle.copyWith(color: grey_80))
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        widget.restaurant.name,
        style:
            headingText.copyWith(color: orange, fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMainImage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Hero(
        tag: '${widget.restaurant.pictureId}',
        child: CachedNetworkImage(
          imageUrl: widget.restaurant.pictureId,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildInfo({String heading, String body, IconData iconData}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(heading, style: smallTitle),
          Row(
            children: [
              if (iconData != null)
                Container(
                  child: Icon(iconData, size: regularIconSize),
                  margin: EdgeInsets.only(right: 8.0),
                ),
              Text(
                body,
                style: paragraphMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetail({String heading, String body}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: smallTitle),
          SizedBox(height: 8.0),
          Text(
            body,
            style: paragraphMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Separator(),
    );
  }
}
