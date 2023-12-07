import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../config/locale/app_localizations.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/assets_images_path.dart';
import '../../../../../localization/presentation/cubit/locale_cubit.dart';
import '../../../domain/entity/get_characters_entities.dart';

class HerosDetails extends StatefulWidget {
  const HerosDetails({
    Key? key,
    // required this.heroIconsModel,

    required this.charactersData,
  }) : super(key: key);

  // final HeroIconsModel heroIconsModel;

  final GetCharactersEntities charactersData;
  @override
  State<HerosDetails> createState() => _HerosDetailsState();
}

class _HerosDetailsState extends State<HerosDetails> {
  late AudioPlayer _audioPlayer;
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  Stream<PossitionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PossitionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PossitionData(
              position, bufferedPosition, duration ?? Duration.zero));
  @override
  void initState() {
    getConnectivity();
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer()
      ..setUrl(
          // "https://assets.mixkit..co/music/preview/mixkit-trip-hop-vibes-149.mp3"
          BlocProvider.of<LocaleCubit>(context).currentLangCode ==
                  AppStrings.englishCode
              ? widget.charactersData.audio_En
              : widget.charactersData.audio_AR);
    _audioPlayer.positionStream;
    _audioPlayer.bufferedPositionStream;
    _audioPlayer.durationStream;
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() {
              isAlertSet = true;
            });
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    // TODO: implement dispose
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLocalImage =
        widget.charactersData.image.contains('http://localhost/storage/') ||
            widget.charactersData.image.isEmpty;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios_outlined,
        //     color: Colors.blue.shade900,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: AutoSizeText(
          AppLocalizations.of(context)!.translate('characters')!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: context.height * 0.3,
                width: context.width * 1,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: isLocalImage
                      ? Image(
                          image: AssetImage(
                            homeImage,
                          ),
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        )
                      : Image(
                          // height: 30,
                          image: NetworkImage(
                            widget.charactersData.image,
                          ),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                  //  Image.asset(
                  //   // heroIconsModel.icon,
                  //   homeImage,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.height * 0.013,
                    ),
                    AutoSizeText(
                      BlocProvider.of<LocaleCubit>(context).currentLangCode ==
                              AppStrings.englishCode
                          ? widget.charactersData.nameEn
                          : widget.charactersData.nameAr,
                      // charactersData.nameEn,
                      // heroIconsModel.title,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.height * 0.013,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: context.height * 0.013,
                    ),
                    Container(
                      // width: context.width * 0.8,
                      height: 150,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // color: Color.fromARGB(255, 95, 230, 214),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Column(
                          children: [
                            StreamBuilder<PossitionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 12, end: 12),
                                  child: ProgressBar(
                                    barHeight: 8,
                                    baseBarColor: Colors.grey[600],
                                    bufferedBarColor: Colors.grey,
                                    progressBarColor:
                                        Color.fromARGB(255, 221, 171, 239),
                                    timeLabelTextStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    thumbColor: Colors.blue,
                                    progress:
                                        positionData?.position ?? Duration.zero,
                                    buffered: positionData?.bufferedPosition ??
                                        Duration.zero,
                                    total:
                                        positionData?.duration ?? Duration.zero,
                                    onSeek: _audioPlayer.seek,
                                  ),
                                );
                              },
                            ),
                            Center(
                              child: Controls(
                                audioPlayer: _audioPlayer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.013,
                    ),
                    AutoSizeText(
                      BlocProvider.of<LocaleCubit>(context).currentLangCode ==
                              AppStrings.englishCode
                          ? widget.charactersData.descriptionEn
                          : widget.charactersData.descriptionAr,
                      // charactersData.descriptionEn,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * .05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogBox() => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('No Connection'),
          content: Text('Please check your internet connectivitu'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, "Cancel");
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: Text('OK'),
            )
          ],
        ),
      );
}

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (!(playing ?? false)) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                width: context.width * 1,
                height: context.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 221, 171, 239),
                ),
                // ignore: dead_code
                child: ElevatedButton(
                    style: ButtonStyle(
                      //padding: EdgeInsets.all(10.0),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 221, 171, 239),
                      ),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          // side: const BorderSide(
                          //     color: Color(0xff04685C), width: 2),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () => audioPlayer.seek(
                              audioPlayer.position -
                                  const Duration(seconds: 10)),
                          iconSize: context.height * 0.05,
                          color: Colors.black,
                          icon: const Icon(Icons.replay_10_rounded),
                        ),
                        const Spacer(),
                        IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: audioPlayer.play,
                            iconSize: context.height * 0.05,
                            color: Colors.black,
                            icon: const Icon(Icons.play_arrow_rounded)),
                        const Spacer(),
                        IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () => audioPlayer.seek(
                              audioPlayer.position +
                                  const Duration(seconds: 10)),
                          iconSize: context.height * 0.05,
                          color: Colors.black,
                          icon: const Icon(Icons.forward_10_rounded),
                        ),
                        const Spacer(),
                      ],
                    ))),
          );
        } else if (processingState != ProcessingState.completed) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                width: context.width * 1,
                height: context.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 221, 171, 239),
                ),
                // ignore: dead_code
                child: ElevatedButton(
                    style: ButtonStyle(
                      //padding: EdgeInsets.all(10.0),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 221, 171, 239),
                      ),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          // side: const BorderSide(
                          //     color: Color(0xff04685C), width: 2),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () => audioPlayer.seek(
                              audioPlayer.position -
                                  const Duration(seconds: 10)),
                          iconSize: context.height * 0.05,
                          color: Colors.black,
                          icon: const Icon(Icons.replay_10_rounded),
                        ),
                        const Spacer(),
                        IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: audioPlayer.pause,
                            iconSize: context.height * 0.05,
                            color: Colors.black,
                            icon: const Icon(Icons.pause_rounded)),
                        const Spacer(),
                        IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () => audioPlayer.seek(
                              audioPlayer.position +
                                  const Duration(seconds: 10)),
                          iconSize: context.height * 0.05,
                          color: Colors.black,
                          icon: const Icon(Icons.forward_10_rounded),
                        ),
                        const Spacer(),
                      ],
                    ))),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              width: context.width * 1,
              height: context.height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 221, 171, 239),
              ),
              // ignore: dead_code
              child: ElevatedButton(
                  style: ButtonStyle(
                    //padding: EdgeInsets.all(10.0),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 221, 171, 239),
                    ),
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        // side: const BorderSide(
                        //     color: Color(0xff04685C), width: 2),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      IconButton(
                        highlightColor: Colors.transparent,
                        onPressed: () => audioPlayer.seek(
                            audioPlayer.position - const Duration(seconds: 10)),
                        iconSize: context.height * 0.05,
                        color: Colors.black,
                        icon: const Icon(Icons.replay_10_rounded),
                      ),
                      const Spacer(),
                      IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: audioPlayer.play,
                          iconSize: context.height * 0.05,
                          color: Colors.black,
                          icon: const Icon(Icons.play_arrow_rounded)),
                      const Spacer(),
                      IconButton(
                        highlightColor: Colors.transparent,
                        onPressed: () => audioPlayer.seek(
                            audioPlayer.position + const Duration(seconds: 10)),
                        iconSize: context.height * 0.05,
                        color: Colors.black,
                        icon: const Icon(Icons.forward_10_rounded),
                      ),
                      const Spacer(),
                    ],
                  ))),
        );
      },
    );
  }
}

class PossitionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PossitionData(this.position, this.bufferedPosition, this.duration);
}
