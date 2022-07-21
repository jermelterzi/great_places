import 'package:flutter/material.dart';
import 'package:great_places/models/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(
          context,
          listen: false,
        ).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Nenhum local cadastrado!'),
                ),
                builder: (context, greatPlaces, child) => greatPlaces
                            .itemsCount ==
                        0
                    ? child!
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: GridTile(
                                footer: GridTileBar(
                                  title: Text(
                                    greatPlaces.itemByIndex(index).title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    greatPlaces
                                        .itemByIndex(index)
                                        .location
                                        .addresss!,
                                    style: const TextStyle(fontSize: 8.0),
                                  ),
                                  backgroundColor: Colors.black54,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.PLACE_DETAIL,
                                      arguments: greatPlaces.itemByIndex(index),
                                    );
                                  },
                                  child: Image(
                                    image: FileImage(
                                        greatPlaces.itemByIndex(index).image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: greatPlaces.itemsCount,
                        ),
                      ),
              ),
      ),
    );
  }
}
