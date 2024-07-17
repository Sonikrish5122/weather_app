import 'package:http/http.dart';
import 'dart:convert';

//class - different , method
// instance - different data

class worker {
  late String location;

  //Constructor

  worker({required this.location}) {
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;

  //Method

  Future<void> getData() async {
    try {
      Uri url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=1f389be55ceadfac8d30ffb2c2ed9563");
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      //Getting Temp,Humidity
      Map tempData = data['main'];
      String getHumidity = tempData['humidity'].toString();
      double getTemp = tempData['temp'] - 273.15;

      print(data);
      //Getting Air

      Map wind = data['wind'];
      double getAir_speed = wind["speed"] / 0.27777777777778;

      //Getting Description

      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data["description"];

      // Assigning Value:
      temp = getTemp.toString(); // c
      humidity = getHumidity; // %
      air_speed = getAir_speed.toString(); // km/hr
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data["icon"].toString();
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "NA";
      main = "NA";
      icon = "03n";
    }
  }
}
