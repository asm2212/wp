import 'package:flutter/material.dart';
import 'package:wp/model/forecast_model.dart';
import 'package:wp/model/weather_model.dart';
import 'package:wp/page/add_info.dart';
import 'package:wp/page/current_weather.dart';
import 'package:wp/services/weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  WeatherService _weatherService = WeatherService();
  Weather? _weather;
  List<Forecast>? _forecast;
  bool _isLoading = false;
  String _city = "Addis Ababa";
  TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Weather weather = await _weatherService.fetchWeather(_city);
      List<Forecast> forecast = await _weatherService.fetchForecast(_city);
      setState(() {
        _weather = weather;
        _forecast = forecast;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'Enter city name',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _city = _cityController.text;
                          });
                          _fetchWeather();
                        },
                      ),
                    ),
                  ),
                ),
                _weather != null
                    ? Column(
                        children: [
                          currentWeather(Icons.wb_sunny_rounded, "${_weather!.temp}", _weather!.cityName ?? ""),
                          SizedBox(
                            height: 60.0,
                          ),
                          Text(
                            "Additional Info",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20.0,
                          ),
                          addInfo("${_weather!.wind}", "${_weather!.humidity}", "${_weather!.pressure}", "${_weather!.feels_like}"),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "5-Day Forecast",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _forecast != null
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: _forecast!.length,
                                    itemBuilder: (context, index) {
                                      Forecast forecast = _forecast![index];
                                      return ListTile(
                                        title: Text(forecast.date),
                                        subtitle: Text(forecast.description),
                                        trailing: Text("${forecast.temp}°C"),
                                      );
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Center(child: Text('Failed to load weather')),
              ],
            ),
    );
  }
}