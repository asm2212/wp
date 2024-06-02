import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wp/model/weather_model.dart';


class WeatherService {
  final String apiKey = '531cf0391607112755206afe56a159b7';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
