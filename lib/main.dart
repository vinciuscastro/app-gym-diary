import 'package:app_gym_yt/services/auth_service.dart';
import 'package:app_gym_yt/views/auth_screen.dart';
import 'package:app_gym_yt/views/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),


          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const IsLogged(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/auth': (context) => AuthScreen(),
        }
    );
  }
}

class IsLogged extends StatelessWidget {
  const IsLogged({super.key});

  @override
  Widget build(BuildContext context) {
    if (AuthService().isLogged()) {
      return HomeScreen();
    } else {
      return const AuthScreen();
    }
  }
}

