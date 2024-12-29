import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/contraction.dart';

Future<void> editDialog(BuildContext context, Contraction contraction) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.editDialogTitle),
        content: Text("blabla"),
        actions: <Widget>[
          FilledButton(
            child: Text(AppLocalizations.of(context)!.actionContinue),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}