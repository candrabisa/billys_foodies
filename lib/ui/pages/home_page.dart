import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:billys_foodies/const/style.dart';
import 'package:billys_foodies/providers/restaurant_provider.dart';
import 'package:billys_foodies/services/restaurant_service.dart';
import 'package:billys_foodies/ui/widgets/list_restaurant_widget.dart';
import 'package:billys_foodies/utils/search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: const Text('Foodies'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
            icon: Icon(
              Icons.search,
              color: kWhiteColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: RestaurantService().getRestaurant(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Restaurant',
                            style: kBlackTextStyle.copyWith(
                              color: kPrimaryColor,
                              fontSize: 20.0,
                              fontWeight: bold,
                            ),
                          ),
                          Text(
                            'Recommendation restauran for you!',
                            style: kBlackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: reguler,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Column(
                      children: restaurantProvider.restaurantList
                          .map(
                            (e) => ListRestaurantWidget(restaurantModel: e),
                          )
                          .toList(),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Tidak ada data'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
