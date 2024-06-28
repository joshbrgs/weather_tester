import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String condition;
  final int codes;

  const WeatherIcon({super.key, required this.condition, required this.codes});

  double _toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  bool _isNight() {
    TimeOfDay now = TimeOfDay.fromDateTime(DateTime.now());

    if (_toDouble(TimeOfDay(hour: 20, minute: 30)) < _toDouble(now) &&
        _toDouble(now) > _toDouble(TimeOfDay(hour: 5, minute: 20))) return true;
    return false;
  }

  String _weatherAnimation() {
    if (this.condition == null) return 'assets/Polite Chicky.json';

    switch (this.condition.toLowerCase()) {
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'drizzle':
        return 'assets/cloudy${_isNight() ? '_night' : ''}.json';
      case 'clouds':
        if (this.codes == 801 || this.codes == 802)
          return 'assets/${_isNight() ? 'night' : 'sunny'}.json';
        return 'assets/cloudy${_isNight() ? '_night' : ''}.json';
      case 'rain':
        return 'assets/showers_w_sun.json';
      case 'snow':
        return 'assets/snow.json';
      case 'clear':
        return 'assets/${_isNight() ? 'night' : 'sunny'}.json';
      case 'mist':
        return 'assets/fog.json';
      case 'smoke':
        return 'assets/fog.json';
      case 'fog':
        return 'assets/fog.json';
      default:
        return 'assets/Polite Chicky.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(_weatherAnimation());
  }
}
