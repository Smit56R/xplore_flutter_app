import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './search_bar_screen.dart';

import '../providers/place_provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-details';
  const PlaceDetailsScreen({Key? key}) : super(key: key);

  Widget photoCard(Uint8List photo) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          width: double.infinity,
          height: 230,
          child: Image.memory(
            photo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _place = Provider.of<PlaceProvider>(context).place;
    if (_place['name'] == null ||
        _place['place_details'] == null ||
        _place['photos'] == null) {
      return const Scaffold(
        body: Center(
          child: Text('Something went wrong!'),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Discover,',
                      style: TextStyle(
                        fontFamily: 'Playfair',
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      '${_place['name'] ?? 'London'}!',
                      style: const TextStyle(
                        fontFamily: 'Playfair',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: FloatingActionButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(SearchBarScreen.routeName),
                    elevation: 0,
                    backgroundColor: const Color.fromRGBO(244, 241, 236, 1),
                    child: const Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: _place['photos'].length,
                itemBuilder: (_, idx) => Column(
                  children: [
                    photoCard(_place['photos'][idx]),
                    const SizedBox(height: 20),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
