import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/core/data/config.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/ui/shared/container/card_container.dart';
import 'package:restaurant_app/ui/shared/separator/separator.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/decoration.dart';
import 'package:restaurant_app/utils/styles/size.dart';
import 'package:restaurant_app/utils/styles/text.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({this.restaurant, this.onPressed});

  final Restaurants restaurant;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      decoration: BaseDecoration.cardDecorationShadow,
      onPressed: onPressed,
      padding: EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(),
          SizedBox(width: 16.0),
          Expanded(child: _buildCardInfo()),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: '${restaurant.pictureId}',
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(smallBorderRadius)),
        child: CachedNetworkImage(
          imageUrl: '${Config.baseSmallImageUrl}${restaurant.pictureId}',
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          height: 90,
          width: 90,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCardInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildSeparator(),
        _buildSubtitle(
          icon: Icons.location_on_outlined,
          text: restaurant.city,
        ),
        SizedBox(height: 4.0),
        _buildSubtitle(
          icon: Icons.star_border,
          text: '${restaurant.rating}',
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      restaurant.name,
      style: smallTitle.copyWith(color: orange),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle({
    IconData icon,
    double iconSize = regularIconSize,
    String text,
    TextStyle textStyle = paragraphMedium,
    Color color = grey_80,
  }) {
    return Row(
      children: [
        if (icon != null)
          Container(
            child: Icon(icon, color: color, size: iconSize),
            margin: EdgeInsets.only(right: 8.0),
          ),
        Text(
          text,
          style: textStyle.copyWith(color: color),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Separator(),
    );
  }
}
