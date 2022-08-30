import 'dart:convert';

import 'package:counter_weather/domain/repositories/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../../core/utils/endpoints.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  @override
  Future<String?> getWeather() async {
    var location = await _determinePosition();
    try {
      final response = await get(Endpoints.getWeather(lat: location.latitude, lon: location.longitude));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String address = await _getAddress(location);
        double mainTemp = data['main']['temp'];
        return 'Weather of $address: ${convertCelsius(mainTemp)} (${convertFahrenheit(mainTemp)})';
      } else {
        debugPrint(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String convertCelsius(double kelvin) {
    return '${(kelvin - 273.15).toStringAsFixed(1)}°C';
  }

  String convertFahrenheit(double kelvin) {
    return '${(kelvin * 9 / 5 - 459.67).toStringAsFixed(1)}°F';
  }

  Future<String> _getAddress(Position location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    final Placemark address = placemarks.first;
    return '${address.country}, ${address.administrativeArea}';
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
