import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            surfaceTintColor: Theme.of(context).colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        Image.asset("assets/images/contractions-min.png").image,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                        label: Text(AppLocalizations.of(context)!.childbirth),
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.labor,
                        style: const TextStyle(
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(3, 3),
                              blurRadius: 20,
                            ),
                          ],
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.8,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(24),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                height: 20,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  left: 16.0,
                  bottom: 32,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      //=> Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorPage())), // TODO authorPage
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image(
                              fit: BoxFit.cover,
                              image:
                                  Image.asset(
                                    "assets/images/2022_ella-min.webp",
                                  ).image,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Manuella Mertens',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  left: 16.0,
                  bottom: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.labor,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.laborText1),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.laborText2),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.laborSubtitle1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 8),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.laborItem1),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 8),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.laborItem2),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 8),
                        SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.laborItem3),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.laborSubtitle2,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.laborText3),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.laborText4),
                    const SizedBox(height: 64),
                    Center(child: buildDisclaimer(context)),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Container buildDisclaimer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.disclaimerTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context)!.disclaimerShort,),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: <TextSpan>[
                TextSpan(text: "${AppLocalizations.of(context)!.resources} "),
                TextSpan(
                  text: 'www.womenshealth.gov',
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap =
                            () => launchUrl(
                              Uri.parse("www.womenshealth.gov"),
                              mode: LaunchMode.externalApplication,
                            ),
                ),
                TextSpan(text: " ${AppLocalizations.of(context)!.and} "),
                TextSpan(
                  text: 'www.nichd.nih.gov/health/topics/labor-delivery',
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap =
                            () => launchUrl(
                              Uri.parse(
                                "https://www.nichd.nih.gov/health/topics/labor-delivery",
                              ),
                              mode: LaunchMode.externalApplication,
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
