import 'package:authentication_flutter/cubit/home/home_cubit.dart';
import 'package:authentication_flutter/screens/home_screen.dart';
import 'package:authentication_flutter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants.dart';
import 'cubit/login/cubit.dart';
import 'cubit/register/register_cubit.dart';
import 'network/local/cache_helper.dart';
import 'screens/login_screen.dart';
import 'network/remote/dio_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  DioHelper.init();

  /// get saved token
  token = CacheHelper.getData('token');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => HomeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      /// If token exists → go to Home
      home: token != null ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}


