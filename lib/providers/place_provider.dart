import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../helpers/places_helper.dart';

class PlaceProvider with ChangeNotifier {
  final Map<String, dynamic> _place = {
    'name': null,
    'place_details': null,
    'photos': null,
  };

  Map<String, dynamic> get place => _place;

  Future<void> setPlace(String name, String placeId) async {
    final placeDetails = await PlacesHelper().getPlaceDetails(placeId);

    final List<Uint8List> photos = [];
    final listOfPhotos = placeDetails['result']['photos'];
    for (int i = 0; i < listOfPhotos.length; i++) {
      final photo = await PlacesHelper()
          .getPlacePhoto(listOfPhotos[i]['photo_reference']);
      photos.add(photo);
    }
    _place['name'] = name;
    _place['place_details'] = placeDetails;
    _place['photos'] = photos;
    notifyListeners();
  }
}
