import 'package:hydrated_bloc/hydrated_bloc.dart';

class NotificationCubit extends HydratedCubit<bool> {
  NotificationCubit() : super(false);

  Future<bool> scheduledRestaurant(bool value) async {
    if (value) {
      print('Scheduling Restaurant Activated');
      emit(value);
      //TODO create notification here
    } else {
      print('Scheduling Restaurant Canceled');
      emit(value);
      //TODO cancel notification here
    }
  }

  @override
  bool fromJson(Map<String, dynamic> json) => json['value'] as bool;

  @override
  Map<String, bool> toJson(bool state) => {'value': state};
}
