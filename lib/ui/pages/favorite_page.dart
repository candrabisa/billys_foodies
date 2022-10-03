import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/favorite_provider.dart';
import '../../ui/widgets/list_restaurant_widget.dart';
import '../../utils/result_state.dart';
import '../../common/style.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
                itemCount: provider.favorite.length,
                itemBuilder: (context, index) {
                  return ListRestaurantWidget(
                    restaurantElement: provider.favorite[index],
                    favorite: true,
                  );
                });
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
