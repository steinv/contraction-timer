// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "actionContinue": MessageLookupByLibrary.simpleMessage("Continue"),
        "actionDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "applicationTitle":
            MessageLookupByLibrary.simpleMessage("Contraction timer - Infans"),
        "deleteContractionDialogDescription":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete this contraction?"),
        "deleteContractionDialogTitle":
            MessageLookupByLibrary.simpleMessage("Delete contraction"),
        "drawerHistory": MessageLookupByLibrary.simpleMessage("History"),
        "drawerTimer":
            MessageLookupByLibrary.simpleMessage("Contraction timer"),
        "guidingText": MessageLookupByLibrary.simpleMessage(
            "Press start on your first contraction"),
        "headerDuration": MessageLookupByLibrary.simpleMessage("Duration"),
        "headerFrequence": MessageLookupByLibrary.simpleMessage("Frequence"),
        "headerTime": MessageLookupByLibrary.simpleMessage("Time"),
        "resetDialogDescription": MessageLookupByLibrary.simpleMessage(
            "Clear the current contraction data. The data will remain available in the history."),
        "resetDialogTitle":
            MessageLookupByLibrary.simpleMessage("Clear contraction data")
      };
}
