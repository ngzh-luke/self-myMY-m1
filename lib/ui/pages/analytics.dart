import 'package:flutter/material.dart';
import 'package:mymy_m1/ui/components/main_view_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return mainView(context,
        appBarTitle: AppLocalizations.of(context)!.heading_analytics,
        body: const Text("Analytics"));
  }
}
