import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../helper/dio.dart';
import '../main.dart';



String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken = "pk.eyJ1Ijoic2Fpa3VtYWFya3VzYW5naSIsImEiOiJjbDhhZGlodDYwOWd6M3VsZjUzMGU1dDhwIn0.S7o9UGqs6tgZsGAmv2ZvtQ";
String searchType = 'place%2Cpostcode%2Caddress';
String searchResultsLimit = '5';
String proximity =
    '${sharedPreferences.getDouble('longitude')}%2C${sharedPreferences.getDouble('latitude')}';
String country = 'In';

Dio _dio = Dio();

Future getSearchResultsFromQueryUsingMapbox(String query) async {
  String url =
      '$baseUrl/$query.json?country=$country&limit=$searchResultsLimit&proximity=$proximity&types=$searchType&access_token=$accessToken';
  url = Uri.parse(url).toString();
  print(url);
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
  }
}