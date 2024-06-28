import 'package:flutter/material.dart';
import '../services/geo_service.dart';
import 'package:dotenv/dotenv.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../components/weather_icon.dart';
import '../providers/theme_provider.dart';
import '../components/theme_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  // var key = env['API_KEY_OPEN_WEATHER'];

  final _weatherService = WeatherService('36341bc6d09296fd445d3d4abc2956ec');
  final _geoService = GeoService();
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _geoService.retrieveCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          themeProvider.themeDataStyle == ThemeDataStyle.dark ? CupertinoIcons.sun_max : CupertinoIcons.moon,
          color: Colors.black,
          size: 36.0,),
        onPressed: () {
          themeProvider.changeTheme();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.map_pin,
                  color: Colors.red,
                  size: 36.0,
                ),
                Text(_weather?.cityName ?? "?"),
              ],
            ),
            WeatherIcon(
              condition: _weather?.condition ?? "",
              codes: _weather?.codes ?? 0,
            ),
            Text('${_weather?.temperature.round()}°F'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.arrow_up,
                  color: Colors.red,
                  size: 36.0,
                ),
                Text('${_weather?.high.round()}°F'),
                SizedBox(width: 50),
                Icon(
                  CupertinoIcons.arrow_down,
                  color: Colors.blue,
                  size: 36.0,
                ),
                Text('${_weather?.low.round()}°F')
              ],
            )
          ],
        ),
      ),
    );
  }
}
