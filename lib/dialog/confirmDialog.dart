import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool?> confirmDialog(BuildContext context, String title, String description) {
  return showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.actionCancel),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.actionContinue),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}