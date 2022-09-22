import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:app_settings/app_settings.dart';
import 'package:billys_foodies/const/style.dart';

class NoConnectionInternetWidget extends StatelessWidget {
  final String msgError;

  const NoConnectionInternetWidget({
    Key? key,
    required this.msgError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          'assets/anims/404_sleep_cat.json',
          width: MediaQuery.of(context).size.width * .8,
          repeat: true,
        ),
        const SizedBox(height: 12),
        Text(
          msgError,
          style: kBlackTextStyle.copyWith(
            fontWeight: reguler,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              AppSettings.openDeviceSettings();
            },
            child: Text(
              'Buka Pengaturan',
              style: kWhiteTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
