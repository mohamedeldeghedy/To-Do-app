
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightMode=ThemeData(
  fontFamily: 'Jannah',


  primarySwatch: Colors.orange,
  textTheme: TextTheme(


      bodyText1: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black)
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.lime[800]),
  appBarTheme:AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 1,
      titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black ),
      backwardsCompatibility:false ,
      systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ) ,
      backgroundColor: Colors.white
  ) ,
  scaffoldBackgroundColor:Colors.white ,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.lime,

  ),
  // floatingActionButtonTheme: ,
);
ThemeData darkMode= ThemeData(fontFamily: 'Jannah',
  primarySwatch: Colors.orange,
  textTheme:
  TextTheme(



      bodyText1: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white)

  ),

  scaffoldBackgroundColor: HexColor('333739'),

  appBarTheme:AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.white ),
      backwardsCompatibility:false ,
      systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor:  HexColor('333739'),
          statusBarIconBrightness: Brightness.light
      ) ,
      backgroundColor: HexColor('333739')
  ) ,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739') ,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey
  ),
  // floatingActionButtonTheme: ,


);