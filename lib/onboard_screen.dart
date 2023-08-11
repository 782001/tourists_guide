import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';

import 'app/auth/login/login_screen.dart';
import 'config/locale/app_localizations.dart';
import 'core/network/local/cashhelper.dart';
import 'core/utils/app_theme_colors.dart';
import 'core/utils/assets_images_path.dart';
import 'core/utils/components.dart';

class BordingScreen extends StatefulWidget {
  const BordingScreen({Key? key, required this.isFromDrawer}) : super(key: key);
  final bool isFromDrawer;

  @override
  _BordingScreenState createState() => _BordingScreenState();
}

class BordingModel {
  final String image;
  final String title;
//   final String image;
//   final String title;
  final String description;

//   PageViewModel(this.image, this.title, );
  BordingModel(
      {required this.image, required this.title, required this.description});
}

class _BordingScreenState extends State<BordingScreen> {
  void Submit() {
    CashHelper.SaveData(key: 'onBording', value: true).then((value) {
      if (value) {
        print('on Bording save true');
        // NavAndFinish(context, HomeScreen());
        // NavAndFinish(context, LoginScreen());
        widget.isFromDrawer
            ? Navigator.pop(context)
            : NavAndFinish(context, LoginScreen());
      }
    });
  }

  var bordingController = PageController();
  bool islast = false;
  @override
  Widget build(BuildContext context) {
    List<BordingModel> bording = [
      BordingModel(
          image: down,
          title: AppLocalizations.of(context)!.translate('downTitle')!,
          description: AppLocalizations.of(context)!.translate('downDec')!),
      // BordingModel(
      //   image: west,
      //   title: AppLocalizations.of(context)!.translate('westTitle')!,
      //   description: AppLocalizations.of(context)!.translate('westDec')!,
      // ),
      // BordingModel(
      //     image: ret,
      //     title: AppLocalizations.of(context)!.translate('retTitle')!,
      //     description: AppLocalizations.of(context)!.translate('retDec')!),
      BordingModel(
          image: ret,
          title: AppLocalizations.of(context)!.translate('coldTitle')!,
          description: AppLocalizations.of(context)!.translate('coldDec')!),
      BordingModel(
          image: practice,
          title: AppLocalizations.of(context)!.translate('practiceTitle')!,
          description: AppLocalizations.of(context)!.translate('practiceDec')!)
    ];

    return Scaffold(
      backgroundColor: AppColors.kwhite,
      appBar: AppBar(
        backgroundColor: AppColors.kwhite,
        elevation: 0,
        actions: [
          FloatingActionButton(
              backgroundColor: Colors.white,
              mini: true,
              onPressed: () {
                Submit();
              },
              child: const Icon(Icons.close, color: Colors.black)),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: bordingController,
                onPageChanged: (int index) {
                  if (index == bording.length - 1) {
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    Build_Bording_Item(bording[index]),
                itemCount: bording.length,
              ),
            ),
            SizedBox(
              height: context.height * .05,
            ),
            // const Spacer(),
            Container(
              width: context.width * 0.35,
              height: context.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: islast ? const Color(0xff04685C) : Colors.white,
              ),
              child: islast
                  ? ElevatedButton(
                      style: ButtonStyle(
                        //padding: EdgeInsets.all(10.0),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff04685C)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Colors.white)),
                        elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                            // if the button is pressed the elevation is 10.0, if not
                            // it is 5.0
                            if (states.contains(MaterialState.pressed)) {
                              return 10.0;
                            }
                            return 0;
                          },
                        ),
                        // textColor: Colors.white,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(
                                  color: Color(0xff04685C), width: 2)),
                        ),
                      ),
                      onPressed: () {
                        Submit();
                      },
                      child: AutoSizeText(
                        AppLocalizations.of(context)!.translate("let'sStart")!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  : Container(),
            ),
            SizedBox(
              height: context.height * .1,
            ),
            SmoothPageIndicator(
                controller: bordingController,
                effect: const ScrollingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  activeDotColor: Color(0xffF89368),
                  dotWidth: 10,
                ),
                count: bording.length),
            SizedBox(
              height: context.height * .03,
            ),
          ],
        ),
      ),
    );
  }

  Widget Build_Bording_Item(BordingModel model) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              // fit: BoxFit.contain,
              image: AssetImage(
                model.image,
              ),
              height: context.height * .3,
            ),
            SizedBox(
              height: context.height * .05,
            ),
            AutoSizeText(
              model.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            const SizedBox(
              height: 7,
            ),
            AutoSizeText(
              model.description,
              style: const TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ],
        ),
      );
}
