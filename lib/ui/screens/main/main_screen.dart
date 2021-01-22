import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/ui/screens/main/widgets/restaurant_card.dart';
import 'package:restaurant_app/ui/screens/screens.dart';
import 'package:restaurant_app/ui/shared/component/scroll_floating_action_button.dart';
import 'package:restaurant_app/utils/sources/images.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/size.dart';
import 'package:restaurant_app/utils/styles/text.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScrollController _scrollController;
  RefreshController _refreshController;
  RestaurantListBloc _restaurantListBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    _restaurantListBloc = RestaurantListBloc();
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _onRequest() {
    _restaurantListBloc.add(RestaurantListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          ScrollFloatingActionButton(scrollController: _scrollController),
      backgroundColor: white,
      body: BlocProvider(
        create: (context) => _restaurantListBloc,
        child: BlocBuilder<RestaurantListBloc, RestaurantListState>(
          builder: (context, state) {
            if (state is RestaurantListInitial) {
              _onRequest();
            }
            if (state is RestaurantListLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is RestaurantListLoadFailure) {
              return _buildError('${state.err}');
            }
            if (state is RestaurantListLoadSuccess) {
              final restaurantList = state.restaurantList;
              return _buildMainScreen(restaurantList);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildMainScreen(RestaurantList restaurantList) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRequest,
      child: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          _buildAppBar(),
          _buildList(restaurantList),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print('search'),
            ),
          ),
        ],
      ),
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

  Widget _buildList(RestaurantList restaurantList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildListItem(restaurantList, index);
        },
        childCount: restaurantList.count,
      ),
    );
  }

  Widget _buildListItem(RestaurantList restaurantList, int index) {
    Restaurants restaurant = restaurantList.restaurants[index];
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

  Widget _buildError(String err) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(GlobalString.failed_request, textAlign: TextAlign.center),
          SizedBox(height: 4.0),
          Text(
            err,
            textAlign: TextAlign.center,
            style: smallCaption.copyWith(color: primary_100),
          ),
          SizedBox(height: 8.0),
          MaterialButton(
            onPressed: _onRequest,
            color: orange,
            child: Text(GlobalString.reload,
                style: buttonLabel.copyWith(color: white)),
          ),
        ],
      ),
    );
  }
}
