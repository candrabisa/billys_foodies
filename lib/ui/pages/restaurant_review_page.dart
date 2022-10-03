import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/restaurant_review_provider.dart';
import '../../utils/show_loading.dart';
import '../../utils/snackbars.dart';
import '../../common/style.dart';
import '../../data/models/restaurant_model.dart';

class RestaurantReviewsPage extends StatefulWidget {
  final RestaurantModel restaurantModel;

  const RestaurantReviewsPage({
    Key? key,
    required this.restaurantModel,
  }) : super(key: key);

  @override
  State<RestaurantReviewsPage> createState() => _RestaurantReviewsPageState();
}

class _RestaurantReviewsPageState extends State<RestaurantReviewsPage> {
  final TextEditingController etNamaController = TextEditingController();
  final TextEditingController etReviewController = TextEditingController();

  @override
  void dispose() {
    etNamaController.dispose();
    etReviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text(
          'Ulasan',
          style: kBlackTextStyle.copyWith(
            fontWeight: reguler,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _modalBottomSheet(context);
            },
            icon: const Icon(
              Icons.add_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.restaurantModel.customerReviews.length,
          itemBuilder: (context, index) {
            var item = widget.restaurantModel.customerReviews[index];
            return ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: kBlackTextStyle.copyWith(
                        fontWeight: bold,
                      ),
                    ),
                  ),
                  Text(
                    item.date,
                    style: kGreyTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                item.review,
                style: kBlackTextStyle.copyWith(
                  fontWeight: reguler,
                ),
              ),
              shape: Border(
                bottom: BorderSide(width: 1, color: kInactiveColor),
              ),
            );
          },
        ),
      ),
    );
  }

  void _modalBottomSheet(BuildContext context) {
    final reviewProvider =
        Provider.of<RestaurantReviewProvider>(context, listen: false);
    handleReviews() async {
      showLoaderDialog(context);
      if (await reviewProvider.sendReviewRestaurant(
          id: widget.restaurantModel.id,
          name: etNamaController.text,
          review: etReviewController.text)) {
        snackBarNoIcon(context, kGreenColor, 'Ulasan berhasil dikirim');
        Navigator.pop(context);
      } else {
        snackBarNoIcon(context, kRedColor, 'Ulasan gagal dikirim');
        Navigator.pop(context);
      }
    }

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 48.0, left: 12.0, right: 12.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 5,
                      height: 8.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: kInactiveColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Tambahkan ulasan untuk restoran ini',
                    style: kBlackTextStyle.copyWith(fontWeight: reguler),
                  ),
                  const SizedBox(height: 24.0),
                  TextField(
                    autofocus: true,
                    controller: etNamaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nama Anda',
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    autofocus: true,
                    controller: etReviewController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ulasan Anda',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      top: 12.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          handleReviews();
                        },
                        child: Text('Kirim Ulasan',
                            style: kWhiteTextStyle.copyWith(fontWeight: bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
