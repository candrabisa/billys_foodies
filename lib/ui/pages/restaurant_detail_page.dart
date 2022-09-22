import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../data/services/api_service.dart';
import '../../const/common.dart';
import '../../const/style.dart';
import '../../ui/pages/restaurant_review_page.dart';
import '../../ui/widgets/list_menu_widget.dart';
import '../../ui/widgets/no_conn_inet_widget.dart';
import '../../providers/restaurant_detail_provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => RestaurantDetailProvider(
        apiService: ApiService(),
        id: widget.restaurantId,
      ),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.resultState == ResultState.loading) {
            return bodyLoading();
          } else if (state.resultState == ResultState.noData) {
            return bodyNoData(state);
          } else if (state.resultState == ResultState.error) {
            return bodyError(state);
          } else if (state.resultState == ResultState.noConn) {
            return bodyNoConn(state);
          } else if (state.resultState == ResultState.hasData) {
            return bodyHasData(state, sizeHeight, context);
          } else {
            return bodyError(state);
          }
        },
      ),
    );
  }

  Widget bodyHasData(
      RestaurantDetailProvider state, double sizeHeight, BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kWhiteColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: urlImageMedium + state.restaurantModel.pictureId,
                    child: Image.network(
                      urlImageMedium + state.restaurantModel.pictureId,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: sizeHeight / 3.3,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.0, top: sizeHeight * .245),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: kPrimaryColor),
                        image: DecorationImage(
                          image: NetworkImage(
                              urlImageSmall + state.restaurantModel.pictureId),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.restaurantModel.name,
                              style: kBlackTextStyle.copyWith(
                                fontSize: 24.0,
                                fontWeight: bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14.0,
                                  color: Colors.black54,
                                ),
                                const SizedBox(
                                  width: 3.0,
                                ),
                                Text(
                                  state.restaurantModel.city,
                                  style: kBlackTextStyle.copyWith(
                                      fontWeight: light),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          splashColor: kPrimaryColor,
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantReviewsPage(
                                  restaurantModel: state.restaurantModel,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.6, color: kInactiveColor),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 18,
                                  color: kSecondaryColor,
                                ),
                                Text(
                                  '${state.restaurantModel.rating} (${state.restaurantModel.customerReviews.length})',
                                  style: kBlackTextStyle.copyWith(
                                    fontWeight: reguler,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Divider(
                      thickness: 1,
                      color: kInactiveColor,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      'Category',
                      style: kBlackTextStyle.copyWith(
                        fontSize: 18.0,
                        fontWeight: bold,
                      ),
                    ),
                    Row(
                      children: state.restaurantModel.categories
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.all(6.0),
                              margin: const EdgeInsets.only(
                                left: 4.0,
                                top: 6.0,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: kGreyColor),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Divider(
                      thickness: 1,
                      color: kInactiveColor,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Informasi',
                      style: kBlackTextStyle.copyWith(
                        fontSize: 18.0,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      state.restaurantModel.description,
                      style: kBlackTextStyle.copyWith(
                        fontWeight: light,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: readMore
                          ? state.restaurantModel.description.length
                          : 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: kPrimaryColor,
                          onTap: () {
                            setState(() {
                              readMore = !readMore;
                            });
                          },
                          child: Text(
                            readMore ? 'Sembunyikan' : 'Baca Selengkapnya',
                            style: kRedTextStyle.copyWith(
                              fontWeight: light,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Daftar Menu',
                        style: kWhiteTextStyle.copyWith(
                          fontSize: 18.0,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Foods:',
                        style: kWhiteTextStyle.copyWith(
                          fontSize: 16.0,
                          fontWeight: reguler,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 12.0),
                          Row(
                            children: state.restaurantModel.menus.foods
                                .map(
                                  (e) => ListMenuWidget(
                                    menuModel: e.name,
                                    images: 'assets/images/img_makanan.png',
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(width: 12.0),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 12.0),
                      child: Text(
                        'Drinks:',
                        style: kWhiteTextStyle.copyWith(
                          fontSize: 16.0,
                          fontWeight: reguler,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 12.0),
                          Row(
                            children: state.restaurantModel.menus.drinks
                                .map(
                                  (e) => ListMenuWidget(
                                    menuModel: e.name,
                                    images: 'assets/images/img_minuman.png',
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(width: 12.0),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyNoConn(RestaurantDetailProvider state) {
    return Scaffold(
        body:
            Center(child: NoConnectionInternetWidget(msgError: state.message)));
  }

  Widget bodyError(RestaurantDetailProvider state) {
    return Scaffold(body: Center(child: Text(state.message)));
  }

  Widget bodyNoData(RestaurantDetailProvider state) {
    return Scaffold(body: Center(child: Text(state.message)));
  }

  Widget bodyLoading() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
