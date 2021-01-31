import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';

class NotificationCubit extends HydratedCubit<bool> {
  NotificationCubit() : super(false);

  Future<bool> scheduleRestaurant(bool value) async {
    if (value) {
      print('Scheduling Restaurant Activated');
      emit(value);
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
      );
    } else {
      print('Scheduling Restaurant Canceled');
      emit(value);
      return await AndroidAlarmManager.cancel(1);
    }
  }

  @override
  bool fromJson(Map<String, dynamic> json) => json['value'] as bool;

  @override
  Map<String, bool> toJson(bool state) => {'value': state};
}
