import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/places_helper.dart';

import '../providers/place_provider.dart';

class SearchBarScreen extends StatefulWidget {
  static const routeName = '/search-bar';
  const SearchBarScreen({Key? key}) : super(key: key);

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  final _searchTextController = TextEditingController();
  bool _loading = false;
  late NavigatorState _navigator;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search a place...',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      onPressed: () => _searchTextController.clear(),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 21,
                  ),
                  controller: _searchTextController,
                  onChanged: (_) => setState(() {}),
                ),
              ),
              if (_loading) const LinearProgressIndicator(),
              Expanded(
                child: FutureBuilder(
                  future: PlacesHelper()
                      .getPlacePredictions(_searchTextController.text),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!['status'] == 'OK') {
                        final List<dynamic> predictions =
                            snapshot.data!['predictions'];
                        return ListView.builder(
                          itemCount: predictions.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ListTile(
                                    title: Text(
                                      predictions[index]['description'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            _loading = true;
                                          });
                                          await Provider.of<PlaceProvider>(
                                                  context,
                                                  listen: false)
                                              .setPlace(
                                                  predictions[index][
                                                          'structured_formatting']
                                                      ['main_text'],
                                                  predictions[index]
                                                      ['place_id']);
                                          _navigator.pop();
                                        },
                                        icon: const Icon(
                                          Icons.search_rounded,
                                        )),
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'No results found!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                          child: Text(
                        'Something went wrong!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
