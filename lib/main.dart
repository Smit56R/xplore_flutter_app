import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/landing_screen.dart';
import './screens/search_place_screen.dart';
import './screens/search_bar_screen.dart';
import './screens/place_details_screen.dart';

import './providers/place_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PlaceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Xplore',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const LandingScreen(),
        routes: {
          SearchPlaceScreen.routeName: (_) => const SearchPlaceScreen(),
          SearchBarScreen.routeName: (_) => const SearchBarScreen(),
          PlaceDetailsScreen.routeName: (_) => const PlaceDetailsScreen(),
        },
      ),
    );
  }
}
