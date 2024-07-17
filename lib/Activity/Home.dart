import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // Import flutter widgets
import 'package:transparent_image/transparent_image.dart'; // Import transparent_image for placeholder
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("This is an init state");
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var cityNames = ["Mumbai", "Delhi", "Chennai", "Dhar", "Indore", "London"];
    final _random = Random();
    var city = cityNames[_random.nextInt(cityNames.length)];
    Map<dynamic, dynamic>? info =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;

    String temp = "NA";
    String air = "NA";
    String icon = "";
    String getCity = "";
    String hum = "";
    String des = "";

    if (info != null) {
      temp = info['temp_value']?.toString() ?? "NA";
      air = info['air_speed_value']?.toString() ?? "NA";

      if (temp != "NA") {
        temp = temp.substring(0, 4);
      }

      if (air != "NA") {
        air = air.substring(0, 4);
      }

      icon = info['icon_value'] ?? "";
      getCity = info['city_value'] ?? "";
      hum = info['hum_value'] ?? "";
      des = info['des_value'] ?? "";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blue[200]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue[800]!,
                    Colors.blue[300]!,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth > 600 ? 60 : 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (searchController.text.trim().isEmpty) {
                                    print("Blank search");
                                  } else {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      "/loading",
                                      arguments: {
                                        "searchText": searchController.text,
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.blueAccent,
                                  ),
                                  margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search $city",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image:
                                    "http://openweathermap.org/img/wn/$icon@4x.png",
                                height: 60,
                                width: 60,
                                fadeInDuration: Duration(milliseconds: 200),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$des",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "In $getCity",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.thermometer),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$temp",
                                    style: TextStyle(fontSize: 90),
                                  ),
                                  Text(
                                    "°C",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 200,
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(WeatherIcons.day_windy),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "$air",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("km/hr"),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 200,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(WeatherIcons.humidity),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "$hum",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Percent"),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Text("Made By Krish Soni"),
                              Text("Data Provided By OpenWeatherApp"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
