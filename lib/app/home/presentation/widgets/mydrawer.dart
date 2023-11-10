import 'package:auto_size_text/auto_size_text.dart';
import 'package:tourist_guide/app/localization/presentation/screens/splash.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import 'package:tourist_guide/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_strings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                color: Colors.white,
              )),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SplashScreen(
                            isFromDrawer: true,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: context.width * 1,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    AutoSizeText(
                      AppLocalizations.of(context)!.translate('Change_lang')!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BordingScreen(
                            isFromDrawer: true,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: context.width * 1,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    AutoSizeText(
                      AppLocalizations.of(context)!.translate('HowTo_Use')!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              // if (!await launchUrl(emailUri,
              //     mode: LaunchMode.externalApplication)) {
              //   throw 'Could not launch $emailUri';
              // }
              if (!await launchUrl(contacturl,
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $contacturl';
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: context.width * 1,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    AutoSizeText(
                      AppLocalizations.of(context)!.translate('contact')!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.contact_support,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
