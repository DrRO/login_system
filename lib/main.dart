import 'package:authentication_flutter/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/register/register_cubit.dart';
import 'login_screen.dart';
import 'network/remote/dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
debugShowCheckedModeBanner: false,

      home: const WelcomeScreen(),
    );
  }
}



