import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/preferences_provider.dart';
import '../../providers/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          ListTile(
            title: const Text('Recommendation Restaurant'),
            leading: const Icon(Icons.notifications),
            trailing:
                Consumer<SchedulingProvider>(builder: (context, scheduled, _) {
              return Switch.adaptive(
                  value: provider.isRecommendRestoActive,
                  onChanged: (value) async {
                    scheduled.scheduledRecommend(value);
                    provider.enableRecommendResto(value);
                  });
            }),
          ),
        ],
      );
    });
  }
}
