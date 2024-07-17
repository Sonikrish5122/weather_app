import 'package:flutter/material.dart';

import 'Activity/Home.dart';
import 'Activity/loading.dart';


void main() {
  runApp(MaterialApp(
    title: "Weather App",
    debugShowCheckedModeBanner: false,
    routes: {
      "/" : (context) => Loading(),
      "/home" : (context) =>  Home(),
      "/loading" : (context) => Loading(),
    },
  ));
}
