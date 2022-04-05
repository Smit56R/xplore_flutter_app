import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../utilities/sensitive_data.dart';

class PlacesHelper {
  Future<Map<String, dynamic>> getPlacePredictions(String searchText) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchText&types=(cities)&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> responseBody = json.decode(response.body);
    return responseBody;
  }

  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> responseBody = json.decode(response.body);
    return responseBody;
  }

  Future<Uint8List> getPlacePhoto(String reference) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/photo?photo_reference=$reference&maxheight=1600&maxwidth=1600&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
