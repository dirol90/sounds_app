import 'package:flutter/material.dart';
import 'package:sounds_app/screen/screen_main_holder.dart';
import 'package:sounds_app/screen/screen_selected_soundes.dart';
import 'package:sounds_app/screen/screen_settings.dart';
import 'package:sounds_app/screen/screen_start.dart';
import 'package:sounds_app/screen/screen_sounds.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sounds',
      theme: ThemeData(
          primaryColor: Color(0xffFFFFFF),
          accentColor: Color(0xff1C174D),
          scaffoldBackgroundColor: Color(0xff1C174D),
          backgroundColor: Color(0xff1C174D),
          buttonColor: Color(0xffFAAE00),
          appBarTheme: AppBarTheme(color: Colors.transparent),
          textTheme: TextTheme(
            title: TextStyle(
                fontSize: 84.0,
                fontWeight: FontWeight.normal,
                color: Color(0xffFFFFFF)),
            subhead: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Color(0xffFFFFFF)),
            body1: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.normal,
                color: Color(0xff000000)),
            body2: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Color(0xffFFFFFF)),
            button: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.normal,
                color: Color(0xffFFFFFF)),
          )),
      routes: {
        SplashScreen.routName: (context) => SplashScreen(),
        MainScreenHolder.routName: (context) => MainScreenHolder(),
        SettingsScreen.routName: (context) => SettingsScreen(),
        SoundsScreen.routName: (context) => SoundsScreen(),
        SelectedSoundsScreen.routName: (context) => SelectedSoundsScreen(),
      },
      initialRoute: SplashScreen.routName,
    );
  }
}
