import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/ui/screens/screens.dart';
import 'package:restaurant_app/ui/shared/component/components.dart';
import 'package:restaurant_app/ui/shared/separator/separator.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/text.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = 'favorite';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  ScrollController _scrollController;
  TextEditingController _textEditingController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollFloatingActionButton(
        scrollController: _scrollController,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBackButton(),
              _buildTitle(),
              _buildSeparator(),
              _buildContent(),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          GlobalString.favorite,
          style: headingText.copyWith(
              fontWeight: FontWeight.normal, color: grey_80),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteInitial) {
          context.read<FavoriteBloc>().add(FavoriteBoxStarted());
        }
        if (state is FavoriteLoadSuccess) {
          final restaurantList = state.restaurantList;
          return _buildList(restaurantList);
        }
        return Container();
      },
    );
  }

  Widget _buildList(RestaurantList restaurantList) {
    return restaurantList.restaurants.length == 0
        ? _buildEmpty()
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _buildListItem(restaurantList, index);
            },
            itemCount: restaurantList.restaurants.length,
            primary: false,
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

  Widget _buildEmpty() {
    return _buildHeightContainer(
      child: Center(
        child: Text(
          FavoriteString.resultEmpty,
          textAlign: TextAlign.center,
          style: paragraphMedium.copyWith(color: grey_80),
        ),
      ),
    );
  }

  Widget _buildHeightContainer({Widget child}) {
    return Container(
      child: child,
      height: MediaQuery.of(context).size.height / 1.5,
      width: double.infinity,
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Separator(),
    );
  }
}
