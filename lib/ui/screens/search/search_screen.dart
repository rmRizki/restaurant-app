import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/shared/component/custom_back_button.dart';
import 'package:restaurant_app/ui/shared/component/scroll_floating_action_button.dart';
import 'package:restaurant_app/ui/shared/component/search_field.dart';
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
      body: ListView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          CustomBackButton(),
          _buildTitle(),
          _buildSearchField(),
          _buildSeparator(),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        GlobalString.search,
        style:
            headingText.copyWith(fontWeight: FontWeight.normal, color: grey_80),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SearchField(
        controller: _textEditingController,
        onSubmitted: (query) {
          print('output search: $query');
        },
        hintText: SearchString.restaurantName,
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Separator(),
    );
  }
}
