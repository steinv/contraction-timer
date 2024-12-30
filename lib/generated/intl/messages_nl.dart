// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'nl';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionCancel": MessageLookupByLibrary.simpleMessage("Annuleren"),
        "actionContinue": MessageLookupByLibrary.simpleMessage("Doorgaan"),
        "actionDelete": MessageLookupByLibrary.simpleMessage("Wissen"),
        "applicationTitle":
            MessageLookupByLibrary.simpleMessage("Weeën  timer - Infans"),
        "deleteContractionDialogDescription":
            MessageLookupByLibrary.simpleMessage(
                "Ben je zeker dat je deze wee wilt verwijderen?"),
        "deleteContractionDialogTitle":
            MessageLookupByLibrary.simpleMessage("Verwijderen"),
        "drawerHistory": MessageLookupByLibrary.simpleMessage("Geschiedenis"),
        "drawerTimer": MessageLookupByLibrary.simpleMessage("Weeën  timer"),
        "guidingText": MessageLookupByLibrary.simpleMessage(
            "Druk op start wanneer je eerste wee start"),
        "headerDuration": MessageLookupByLibrary.simpleMessage("Duur"),
        "headerFrequence": MessageLookupByLibrary.simpleMessage("Frequentie"),
        "headerTime": MessageLookupByLibrary.simpleMessage("Tijdstip"),
        "resetDialogDescription": MessageLookupByLibrary.simpleMessage(
            "Wis de huidige gegevens. Je kan jouw vorige gegevens terug vinden in de geschiedenis."),
        "resetDialogTitle":
            MessageLookupByLibrary.simpleMessage("Gegevens wissen")
      };
}
