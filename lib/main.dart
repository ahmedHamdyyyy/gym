import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/Screen/Home.dart';
import 'package:gym/componentes/observal.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: HexColor("333739"),
        floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor("333739"),
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: HexColor("333739"),
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: HexColor("333739"),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      home:  MyHomePage(),
    );
  }
}

