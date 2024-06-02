class Forecast {
  final String date;
  final double temp;
  final String description;

  Forecast({
    required this.date,
    required this.temp,
    required this.description,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: json['dt_txt'],
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
    );
  }
}
