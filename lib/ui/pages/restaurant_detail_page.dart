import 'package:billys_foodies/const/style.dart';
import 'package:billys_foodies/providers/restaurant_provider.dart';
import 'package:billys_foodies/ui/widgets/list_menu_widget.dart';
import 'package:flutter/material.dart';

import 'package:billys_foodies/models/restaurant_model.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  final RestaurantModel restaurantModel;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurantModel,
  }) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final sizeHeight = MediaQuery.of(context).size.height;

    Widget header() {
      return Stack(
        children: [
          Image.network(
            widget.restaurantModel.pictureId,
            fit: BoxFit.cover,
            width: double.infinity,
            height: sizeHeight / 3.3,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: sizeHeight * .245),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: kPrimaryColor),
                image: DecorationImage(
                  image: NetworkImage(widget.restaurantModel.pictureId),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget infoResto() {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0),
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
                      widget.restaurantModel.name,
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
                          widget.restaurantModel.city,
                          style: kBlackTextStyle.copyWith(fontWeight: light),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 24,
                      color: kSecondaryColor,
                    ),
                    Text(
                      widget.restaurantModel.rating.toString(),
                      style: kBlackTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
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
              'Informasi',
              style: kBlackTextStyle.copyWith(
                fontSize: 18.0,
                fontWeight: bold,
              ),
            ),
            Text(
              widget.restaurantModel.description,
              style: kBlackTextStyle.copyWith(
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
              maxLines:
                  readMore ? widget.restaurantModel.description.length : 5,
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
      );
    }

    Widget daftarMenu() {
      return Container(
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
                    children: restaurantProvider.restaurantList
                        .map(
                          (e) => ListMenuWidget(
                            foodModel: e.menus.foods.first,
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
                    children: restaurantProvider.restaurantList
                        .map(
                          (e) => ListMenuWidget(
                            foodModel: e.menus.drinks.first,
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: true,
        title: Text(widget.restaurantModel.name),
      ),
      body: ListView(
        children: [
          header(),
          infoResto(),
          daftarMenu(),
        ],
      ),
    );
  }
}
