import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/ui/screens/screens.dart';
import 'package:restaurant_app/ui/shared/component/restaurant_card.dart';
import 'package:restaurant_app/ui/shared/component/scroll_floating_action_button.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/navigation.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
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
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  ScrollController _scrollController;
  RefreshController _refreshController;
  MainBloc _mainBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    _refreshController = RefreshController();
    _mainBloc = MainBloc();
    port.listen((_) async => await _service.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(DetailScreen.routeName);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    selectNotificationSubject.close();
    super.dispose();
  }

  _onRequest() {
    _mainBloc.add(MainRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          ScrollFloatingActionButton(scrollController: _scrollController),
      backgroundColor: white,
      body: BlocProvider(
        create: (context) => _mainBloc,
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state is MainInitial) {
              _onRequest();
            }
            if (state is MainLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MainLoadFailure) {
              return _buildError('${state.err}');
            }
            if (state is MainLoadSuccess) {
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
      header: MaterialClassicHeader(color: orange),
      child: CustomScrollView(
        shrinkWrap: true,
        primary: false,
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          _buildList(restaurantList),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      leading: _buildNavigatorIcon(
          iconData: Icons.search, routeName: SearchScreen.routeName),
      actions: [
        _buildNavigatorIcon(
            iconData: Icons.favorite, routeName: FavoriteScreen.routeName),
        _buildNavigatorIcon(
            iconData: Icons.settings, routeName: SettingScreen.routeName),
      ],
      expandedHeight: 256.0,
      elevation: softElevation,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        title: SafeArea(
          child: Text(GlobalString.title,
              style: bigTitle.copyWith(
                  fontWeight: FontWeight.normal, color: grey_80)),
        ),
        centerTitle: true,
        background: SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: 64, top: 48),
            child: SvgPicture.asset(BaseImages.headerIllustration),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigatorIcon({IconData iconData, String routeName = ''}) {
    return IconButton(
      icon: Icon(iconData, color: grey_80),
      onPressed: () {
        if (routeName.isNotEmpty) {
          Navigation.pushNamed(routeName);
        }
      },
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
      margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
      child: RestaurantCard(
        restaurant: restaurant,
        onPressed: () => Navigation.pushNamed(
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
          Text(
            GlobalString.failed_request,
            textAlign: TextAlign.center,
            style: paragraphMedium.copyWith(color: grey_80),
          ),
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
