import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';
import 'package:restaurant_app/core/data/config.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/ui/shared/component/components.dart';
import 'package:restaurant_app/ui/shared/separator/separator.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/size.dart';
import 'package:restaurant_app/utils/styles/text.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = 'detail';

  final Restaurant restaurant;

  DetailScreen({this.restaurant});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<String> _foods = [];
  List<String> _drinks = [];
  List<String> _categories = [];
  String _address = '';
  ScrollController _scrollController;
  DetailBloc _detailBloc;
  RefreshController _refreshController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _refreshController = RefreshController();
    _detailBloc = DetailBloc();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  _onDetailRequest(String id) {
    _detailBloc.add(DetailRequested(id: id));
  }

  _clearList() {
    _categories.clear();
    _foods.clear();
    _drinks.clear();
  }

  _addRequestInfo(String info) {
    _address = info;
    _clearList();
    _categories.add(info);
    _foods.add(info);
    _drinks.add(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollFloatingActionButton(
        scrollController: _scrollController,
      ),
      body: BlocProvider(
        create: (context) => _detailBloc,
        child: BlocConsumer<DetailBloc, DetailState>(
          listener: (context, state) {
            if (_refreshController.isRefresh) {
              _refreshController.refreshCompleted();
            }
          },
          builder: (context, state) {
            if (state is DetailInitial) {
              _onDetailRequest(widget.restaurant.id);
            }
            if (state is DetailLoadInProgress) {
              _addRequestInfo(GlobalString.requesting);
            }
            if (state is DetailLoadFailure) {
              _addRequestInfo(GlobalString.failed_request);
            }
            if (state is DetailLoadSuccess) {
              _clearList();
              Restaurant restaurant = state.restaurantDetail.restaurant;
              _address = restaurant.address;
              restaurant
                ..categories.forEach((element) => _categories.add(element.name))
                ..menus.foods.forEach((element) => _foods.add(element.name))
                ..menus.drinks.forEach((element) => _drinks.add(element.name));
            }
            return _buildDetailContent();
          },
        ),
      ),
    );
  }

  Widget _buildDetailContent() {
    return SmartRefresher(
      controller: _refreshController,
      scrollController: _scrollController,
      header: MaterialClassicHeader(color: orange),
      physics: BouncingScrollPhysics(),
      onRefresh: () => _onDetailRequest(widget.restaurant.id),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAppbar(),
              _buildTitle(),
              _buildMainImage(),
              _buildHorizontalInfo(
                heading: DetailString.city,
                body: widget.restaurant.city,
                iconData: Icons.location_on_outlined,
              ),
              _buildSeparator(),
              _buildHorizontalInfo(
                heading: DetailString.address,
                body: _address,
              ),
              _buildSeparator(),
              _buildHorizontalInfo(
                heading: DetailString.rating,
                body: '${widget.restaurant.rating}',
                iconData: Icons.star_border,
              ),
              _buildSeparator(),
              _buildVerticalInfo(
                heading: DetailString.description,
                body: widget.restaurant.description,
              ),
              _buildVerticalInfo(
                  heading: DetailString.categories,
                  body: '${_categories.join(', ')}'),
              _buildVerticalInfo(
                  heading: DetailString.food, body: '${_foods.join(', ')}'),
              _buildVerticalInfo(
                  heading: DetailString.drink, body: '${_drinks.join(', ')}'),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackButton(),
        IconButton(
          icon: Icon(Icons.favorite_outline, color: grey_80),
          onPressed: () {},
          splashRadius: 0.5,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          widget.restaurant.name,
          style: headingText.copyWith(
              color: orange, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildMainImage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Hero(
        tag: '${widget.restaurant.pictureId}',
        child: CachedNetworkImage(
          imageUrl: '${Config.baseSmallImageUrl}${widget.restaurant.pictureId}',
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildHorizontalInfo(
      {String heading, String body, IconData iconData}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(heading, style: paragraphSemiBold),
          Row(
            children: [
              if (iconData != null)
                Container(
                  child: Icon(iconData, size: regularIconSize),
                  margin: EdgeInsets.only(right: 8.0),
                ),
              Text(body, style: paragraphMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalInfo({String heading, String body}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: paragraphSemiBold, textAlign: TextAlign.justify),
          SizedBox(height: 8.0),
          Text(body, style: paragraphMedium),
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
