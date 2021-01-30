import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/blocs/cubit/notification_cubit.dart';
import 'package:restaurant_app/ui/shared/component/components.dart';
import 'package:restaurant_app/ui/shared/separator/separator.dart';
import 'package:restaurant_app/utils/sources/strings.dart';
import 'package:restaurant_app/utils/styles/colors.dart';
import 'package:restaurant_app/utils/styles/text.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = 'setting';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isOn;

  @override
  void initState() {
    isOn = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBackButton(),
              _buildTitle(),
              _buildSeparator(),
              _buildList(),
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
          GlobalString.setting,
          style: headingText.copyWith(
              fontWeight: FontWeight.normal, color: grey_80),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      shrinkWrap: true,
      primary: false,
      children: [
        Material(
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(SettingString.dailyNotif),
                Text(SettingString.dailyNotifDesc,
                    style: captionMedium.copyWith(color: grey_80)),
              ],
            ),
            trailing: BlocBuilder<NotificationCubit, bool>(
              builder: (context, state) {
                return Switch.adaptive(
                  value: state,
                  onChanged: (value) async {
                    var snackBar;
                    if (Platform.isIOS) {
                      snackBar =
                          SnackBar(content: Text('Not Supported for iOS'));
                    } else {
                      snackBar = SnackBar(
                          content: Text(
                              'Notification ${value ? 'started' : 'stopped'}'));
                      context
                          .read<NotificationCubit>()
                          .scheduledRestaurant(value);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Separator(),
    );
  }
}
