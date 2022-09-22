import 'package:flutter/material.dart';
import '../../const/common.dart';
import '../../data/models/restaurant_result_model.dart';
import '../../const/style.dart';
import '../../ui/pages/restaurant_detail_page.dart';

class ListRestaurantWidget extends StatelessWidget {
  final RestaurantElement restaurantElement;

  const ListRestaurantWidget({
    Key? key,
    required this.restaurantElement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailPage(
              restaurantId: restaurantElement.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: kWhiteColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Hero(
                      tag: restaurantElement.pictureId,
                      child: Image.network(
                        urlImageSmall + restaurantElement.pictureId,
                        width: sizeWidth / 3.4,
                        height: sizeHeight * .1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          restaurantElement.name,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16.0,
                            fontWeight: bold,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 12,
                              color: kGreyColor,
                            ),
                            const SizedBox(width: 3.0),
                            Text(
                              restaurantElement.city,
                              style: TextStyle(
                                color: kGreyColor,
                                fontSize: 12.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.0),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: kSecondaryColor,
                            ),
                            Text(
                              restaurantElement.rating.toString(),
                              style: kBlackTextStyle.copyWith(
                                fontSize: 14.0,
                                fontWeight: light,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: kInactiveColor,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
