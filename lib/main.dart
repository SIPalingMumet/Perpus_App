import 'package:flutter/material.dart';
import 'package:perpus_app/home.dart';
import 'package:perpus_app/AddPage.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home':(context) => Homage(),
      '/Pindah':(context) => AddPage()
    },
  ));
}