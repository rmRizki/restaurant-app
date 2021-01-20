import 'package:flutter/material.dart';
import 'package:restaurant_app/core/models/restaurant/restaurant_response.dart';
import 'package:restaurant_app/utils/file_helper.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Restaurants> _restaurantList = [];

  @override
  void initState() {
    _getRestaurantList();
    super.initState();
  }

  _getRestaurantList() async {
    final data = await readJson(context, 'assets/local_restaurant.json');
    RestaurantResponse rs = RestaurantResponse.fromJson(data);
    setState(() {
      _restaurantList = rs.restaurants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                icon: Icon(Icons.filter_1),
                onPressed: () {
                  // Do something
                }),
            expandedHeight: 220.0,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 50,
            backgroundColor: Colors.pink,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                  fit: BoxFit.cover,
                )),
          ),
          new SliverList(
              delegate:
                  new SliverChildListDelegate(_buildList(_restaurantList))),
        ],
      ),
    );
  }

  List _buildList(List<Restaurants> restaurants) {
    List<Widget> listItems = [];

    for (int i = 0; i < restaurants.length; i++) {
      listItems.add(Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('Item ${restaurants[i].name}',
              style: TextStyle(fontSize: 25.0))));
    }

    return listItems;
  }
}
