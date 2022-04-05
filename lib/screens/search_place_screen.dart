import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './search_bar_screen.dart';
import './place_details_screen.dart';

import '../providers/place_provider.dart';

class SearchPlaceScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchPlaceScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlaceScreen> createState() => _SearchPlaceScreenState();
}

class _SearchPlaceScreenState extends State<SearchPlaceScreen> {
  //ChIJwe1EZjDG5zsRaYxkjY_tpF0 - Mumbai
  bool _setInitialData = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_setInitialData) {
      await Provider.of<PlaceProvider>(context, listen: false).setPlace(
        'Mumbai',
        'ChIJwe1EZjDG5zsRaYxkjY_tpF0',
      );
      _setInitialData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final _place = Provider.of<PlaceProvider>(context).place;
    if (_place['name'] == null) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: mediaQuery.height,
              width: mediaQuery.width,
              child: FittedBox(
                child: Image.asset(
                  'assets/images/landing_page_bg.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: mediaQuery.height,
            width: mediaQuery.width,
            child: FittedBox(
              // alignment: Alignment.bottomCenter,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Image.memory(
                  _place['photos'][0],
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'LET\'S GO!',
                        style: TextStyle(
                          color: Color.fromRGBO(234, 130, 70, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.6,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          onPressed: () => Navigator.of(context)
                              .pushNamed(SearchBarScreen.routeName),
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                      color: Color.fromRGBO(229, 228, 223, 1), thickness: 1),
                  const Text(
                    'Choose\nyour city',
                    style: TextStyle(
                      fontFamily: 'Playfair',
                      fontSize: 45,
                    ),
                  ),
                  const SizedBox(height: 38),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black,
                          height: 369,
                          width: double.infinity,
                          child: Image.memory(
                            _place['photos'][0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          _place['name'].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            letterSpacing: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      child: const Text(
                        'EXPLORE THE CITY',
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.6,
                        ),
                      ),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(PlaceDetailsScreen.routeName),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: const Color.fromARGB(3, 0, 0, 0),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
