import 'package:billys_foodies/models/restaurant_model.dart';
import 'package:billys_foodies/providers/restaurant_provider.dart';
import 'package:billys_foodies/ui/pages/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    List<RestaurantModel> getResto =
        restaurantProvider.restaurantList.where((element) {
      final resultName = element.name.toLowerCase();
      final resultCity = element.city.toLowerCase();
      final input = query.toLowerCase();

      if (resultName.contains(input)) {
        return resultName.contains(input);
      } else {
        return resultCity.contains(input);
      }
    }).toList();

    return ListView.builder(
        itemCount: getResto.length,
        itemBuilder: (context, index) {
          final getData = getResto[index];

          return ListTile(
            title: Text(getData.name),
            subtitle: Text(getData.city),
            onTap: () {
              query = getData.name;
              showResults(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(
                    restaurantModel: getData,
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    List<RestaurantModel> getResto =
        restaurantProvider.restaurantList.where((element) {
      final resultName = element.name.toLowerCase();
      final resultCity = element.city.toLowerCase();
      final input = query.toLowerCase();

      if (resultName.contains(input)) {
        return resultName.contains(input);
      } else {
        return resultCity.contains(input);
      }
    }).toList();

    return ListView.builder(
        itemCount: getResto.length,
        itemBuilder: (context, index) {
          final getData = getResto[index];

          return ListTile(
            title: Text(getData.name),
            subtitle: Text(getData.city),
            onTap: () {
              query = getData.name;
              showResults(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(
                    restaurantModel: getData,
                  ),
                ),
              );
            },
          );
        });
  }
}
