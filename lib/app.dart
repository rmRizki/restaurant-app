import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/blocs/favorite/favorite_bloc.dart';
import 'package:restaurant_app/core/routes/app_route.dart';
import 'package:restaurant_app/ui/screens/screens.dart';
import 'package:restaurant_app/utils/navigation.dart';
import 'package:restaurant_app/utils/sources/font.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: GlobalString.title,
        theme: ThemeData(
          primaryColor: white,
          fontFamily: FontFamily.montserrat,
          accentColor: orange,
        ),
        initialRoute: MainScreen.routeName,
        onGenerateRoute: AppRoute.generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
