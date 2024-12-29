import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/timerPage.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.timer),
          title: Text(AppLocalizations.of(context)!.drawerTimer),
          selected: true,
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TimerPage())),
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: Text(AppLocalizations.of(context)!.drawerHistory),
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TimerPage())),
        ),
      ],
    ),
  );
}
