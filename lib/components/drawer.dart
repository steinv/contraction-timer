import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

NavigationDrawer buildDrawer(BuildContext context, int selectedIndex) {
  return NavigationDrawer(
    selectedIndex: selectedIndex,
    children: <Widget>[
      Padding(padding: const EdgeInsets.fromLTRB(28, 16, 16, 10)),
      NavigationDrawerDestination(
        icon: const Icon(Icons.timer),
        label: Text(AppLocalizations.of(context)!.drawerTimer),
      ),
      NavigationDrawerDestination(icon: const Icon(Icons.history), label: Text(AppLocalizations.of(context)!.drawerHistory)),
      const Padding(padding: EdgeInsets.fromLTRB(28, 16, 28, 10), child: Divider()),
      Center(
        child: TextButton(
          onPressed: () => launchUrl(Uri.parse("https://infans.be"), mode: LaunchMode.externalApplication),
          child: Text("Made by Infans"),
        ),
      ),
    ],
    onDestinationSelected: (int index) {
      if(index != selectedIndex) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/timer');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/history');
        }
      }
    },
  );
}
