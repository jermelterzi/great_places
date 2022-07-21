import 'package:flutter/material.dart';
import 'package:great_places/models/great_places.dart';
import 'package:great_places/pages/place_detail_page.dart';
import 'package:great_places/pages/place_form_page.dart';
import 'package:great_places/pages/places_list_page.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ).copyWith(
            colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.indigo,
          secondary: Colors.amber,
        )),
        routes: {
          AppRoutes.PLACES_LIST: ((context) => const PlacesListPage()),
          AppRoutes.PLACE_FORM: ((context) => const PlaceFormPage()),
          AppRoutes.PLACE_DETAIL: ((context) => const PlaceDetailPage()),
        },
      ),
    );
  }
}
