import 'package:flutter/material.dart';

import 'package:xplore_app/screens/search_place_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
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
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const Divider(
                    color: Color.fromRGBO(229, 228, 223, 1), thickness: 1),
                const Text(
                  'Hello,',
                  style: TextStyle(
                    fontFamily: 'Playfair',
                    fontSize: 45,
                    color: Color.fromRGBO(114, 151, 143, 1),
                  ),
                ),
                const Text(
                  'Wanderer!',
                  style: TextStyle(
                    fontFamily: 'Playfair',
                    fontSize: 45,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 74,
                  child: ElevatedButton(
                    child: const Text(
                      'EXPLORE',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.6,
                      ),
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(SearchPlaceScreen.routeName),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
