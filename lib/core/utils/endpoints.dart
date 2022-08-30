import '../../config/constants/keys.dart';

class Endpoints {
  static Uri getWeather({required double lat, required double lon}) => Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        queryParameters: {
          'lat': '$lat',
          'lon': '$lon',
          'appid': weatherApiKey,
        },
      );
}
