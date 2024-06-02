import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wp/model/forecast_model.dart';
import 'package:wp/model/weather_model.dart';


class WeatherService {
  final String apiKey = '';your api
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
   final String forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
  Future<List<Forecast>> fetchForecast(String city) async {
    final response = await http.get(Uri.parse('$forecastUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> list = data['list'];
      return list.map((json) => Forecast.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}
