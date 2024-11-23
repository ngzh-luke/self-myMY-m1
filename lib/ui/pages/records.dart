import 'package:flutter/material.dart'
    show BuildContext, State, StatefulWidget, Text, Widget;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

import 'package:mymy_m1/ui/components/main_view_template.dart' show mainView;

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    return mainView(context,
        appBarTitle: AppLocalizations.of(context)!.heading_records,
        body: const Text("Transaction Records"));
  }
}
