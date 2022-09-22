import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/style.dart';
import '../../providers/restaurant_search_provider.dart';
import '../widgets/list_restaurant_widget.dart';
import '../widgets/no_conn_inet_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const String routeName = '/search-page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController etSearchController = TextEditingController();

  @override
  void dispose() {
    etSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            searchHeader(context),
            bodyResult(context),
          ],
        ),
      ),
    );
  }

  Widget bodyResult(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.resultState == ResultState.loading) {
          return Center(
            child: Column(
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 48.0,
                ),
                const SizedBox(height: 18),
                Text(
                  'Sedang mencari restaurant\nHarap menunggu...',
                  textAlign: TextAlign.center,
                  style: kBlackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                )
              ],
            ),
          );
        } else if (state.resultState == ResultState.noData) {
          return Center(
            child: Text(
              'Restaurant tidak ditemukan',
              style: kBlackTextStyle.copyWith(fontWeight: light),
            ),
          );
        } else if (state.resultState == ResultState.noConn) {
          return NoConnectionInternetWidget(msgError: state.message);
        } else if (state.resultState == ResultState.hasData) {
          return Column(
            children: state.searchModel!.restaurants
                .map((e) => ListRestaurantWidget(restaurantElement: e))
                .toList(),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }

  Widget searchHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pencarian',
            style: kBlackTextStyle.copyWith(
              color: kPrimaryColor,
              fontWeight: semiBold,
              fontSize: 24.0,
            ),
          ),
          Consumer<RestaurantSearchProvider>(
            builder: (context, state, _) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: TextField(
                      controller: etSearchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        hintText: 'Cari Restaurant...',
                      ),
                      onChanged: (query) {
                        if (query.isNotEmpty) {
                          state.fetchSearchRestaurant(query);
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Widget bodyResult(BuildContext context) {

  // }
}
