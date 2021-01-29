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

class SearchScreen extends StatefulWidget {
  static const routeName = 'search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController;
  TextEditingController _textEditingController;
  SearchBloc _searchBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    _searchBloc = context.read<SearchBloc>()..add(SearchRequested(query: ''));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  _onSearch(String query) {
    _searchBloc.add(SearchRequested(query: query));
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
              _buildSearchField(),
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
          GlobalString.search,
          style: headingText.copyWith(
              fontWeight: FontWeight.normal, color: grey_80),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SearchField(
        controller: _textEditingController,
        onSubmitted: (query) => _onSearch(query),
        hintText: SearchString.restaurantName,
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          _onSearch('');
        }
        if (state is SearchLoadInProgress) {
          return _buildLoading();
        }
        if (state is SearchLoadFailure) {
          return _buildError('${state.err}');
        }
        if (state is SearchLoadSuccess) {
          final restaurantList = state.restaurantList;
          return _buildList(restaurantList);
        }
        return Container();
      },
    );
  }

  Widget _buildList(RestaurantList restaurantList) {
    return restaurantList.founded == 0
        ? _buildEmpty()
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _buildListItem(restaurantList, index);
            },
            itemCount: restaurantList.founded,
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

  Widget _buildLoading() {
    return _buildHeightContainer(
        child: Center(child: CircularProgressIndicator()));
  }

  Widget _buildEmpty() {
    return _buildHeightContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Text(
            SearchString.resultEmpty,
            textAlign: TextAlign.center,
            style: paragraphMedium.copyWith(color: grey_80),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String err) {
    return _buildHeightContainer(
      child: Padding(
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
              onPressed: () => _onSearch(_textEditingController.text),
              color: orange,
              child: Text(GlobalString.reload,
                  style: buttonLabel.copyWith(color: white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightContainer({Widget child}) {
    return Container(
        child: child,
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity);
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Separator(),
    );
  }
}
