import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/style.dart';
import '../../providers/restaurant_list_provider.dart';
import '../../ui/pages/search_page.dart';
import '../widgets/list_restaurant_widget.dart';
import '../widgets/no_conn_inet_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: const Text('Foodies'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
            icon: Icon(
              Icons.search,
              color: kWhiteColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: Consumer<RestaurantListProvider>(
          builder: (context, state, _) {
            if (state.resultState == ResultState.loading) {
              return const CircularProgressIndicator();
            } else if (state.resultState == ResultState.hasData) {
              return bodyHasData(state);
            } else if (state.resultState == ResultState.noData) {
              return bodyNoData(state);
            } else if (state.resultState == ResultState.error) {
              return Center(child: Text(state.message));
            } else if (state.resultState == ResultState.noConn) {
              return bodyNoConn(state);
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }

  Center bodyNoConn(RestaurantListProvider state) {
    return Center(
                child: NoConnectionInternetWidget(msgError: state.message));
  }

  Center bodyNoData(RestaurantListProvider state) {
    return Center(
      child: Text(state.message),
    );
  }

  ListView bodyHasData(RestaurantListProvider state) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
          children: state.resultModel.restaurants
              .map(
                (e) => ListRestaurantWidget(
                  restaurantElement: e,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
