import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
     final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=imperial'));

     if (response.statusCode == 200) {
       print(jsonDecode(response.body));
       return Weather.fromJson(jsonDecode(response.body));
     } else {
       throw Exception("Failed to load weather data");
     }

  }

}


