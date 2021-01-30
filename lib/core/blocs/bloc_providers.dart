import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs.dart';

List<BlocProvider<Object>> providers = [
  BlocProvider<MainBloc>(
    create: (context) => MainBloc(),
  ),
  BlocProvider<SearchBloc>(
    create: (context) => SearchBloc(),
  ),
  BlocProvider<DetailBloc>(
    create: (context) => DetailBloc(),
  ),
  BlocProvider<FavoriteBloc>(
    create: (context) => FavoriteBloc(),
  ),
  BlocProvider<NotificationCubit>(
    create: (context) => NotificationCubit(),
  )
];
