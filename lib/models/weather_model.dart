class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final int sunset;
  final int sunrise;
  final double high;
  final double low;
  final int codes;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.condition,
      required this.sunset,
      required this.sunrise,
      required this.codes,
      required this.high,
      required this.low});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        condition: json['weather'][0]['main'],
        sunset: json['sys']['sunset'],
        sunrise: json['sys']['sunrise'],
        high: json['main']['temp_max'].toDouble(),
        low: json['main']['temp_min'].toDouble(),
        codes: json['weather'][0]['id']);
  }
}
