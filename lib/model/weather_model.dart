class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? feels_like;
  int? pressure;

  Weather({
    this.cityName,
    this.temp,
    this.wind,
    this.humidity,
    this.feels_like,
    this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'],
      wind: json['wind']['speed'],
      humidity: json['main']['humidity'],
      feels_like: json['main']['feels_like'],
      pressure: json['main']['pressure'],
    );
  }
}
