// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_cubit_stream_subscription/exceptions/weather_exceptions.dart';
import 'package:weather_cubit_stream_subscription/models/custom_error.dart';
import 'package:weather_cubit_stream_subscription/models/direct_geocoding.dart';
import 'package:weather_cubit_stream_subscription/services/weather_api_services.dart';

import '../models/weather.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);
      print("directGeocoding : $directGeocoding");

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
