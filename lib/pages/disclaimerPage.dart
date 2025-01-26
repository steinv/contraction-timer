import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisclaimerPage extends StatefulWidget {
  static final String DISCLAIMER_AGREED = 'has_agreed_disclaimer';

  const DisclaimerPage({super.key});

  @override
  DisclaimerPageState createState() => DisclaimerPageState();
}

class DisclaimerPageState extends State<DisclaimerPage> {
  bool _hasReadDisclaimer = false;

  @override
  void initState() {
    super.initState();
    _checkIfAgreed();
  }

  // Check if the user has already agreed to the disclaimer
  Future<void> _checkIfAgreed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? hasAgreed = prefs.getBool(DisclaimerPage.DISCLAIMER_AGREED) ?? false;

    if (hasAgreed) {
      // Navigate to the main screen if already agreed
      Navigator.pushReplacementNamed(context, '/timer');
    }
  }

  // Save the agreement status
  Future<void> _saveAgreement(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(DisclaimerPage.DISCLAIMER_AGREED, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.disclaimerTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.disclaimerFull, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(AppLocalizations.of(context)!.disclaimerAgree),
                    value: _hasReadDisclaimer,
                    onChanged: (bool? value) {
                      setState(() {
                        _hasReadDisclaimer = value ?? false;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                        onPressed:
                            _hasReadDisclaimer
                                ? () async {
                                  await _saveAgreement(true);
                                  Navigator.pushReplacementNamed(context, '/timer');
                                }
                                : null,
                        child: Text(AppLocalizations.of(context)!.actionContinue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
