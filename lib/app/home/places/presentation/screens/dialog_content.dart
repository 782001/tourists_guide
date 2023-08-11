import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tourist_guide/app/home/places/domain/entity/get_places_entities.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../config/locale/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' as flutter;

import '../../../../../core/utils/app_strings.dart';
import '../../../../localization/presentation/cubit/locale_cubit.dart';

class DialogContent extends StatefulWidget {
  const DialogContent({super.key, required this.entity});
  final GetPlacesEntities entity;
  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  late AudioPlayer _audioPlayer;
  // Duration duration = const Duration();
  // Duration possiton = const Duration();
  // bool playing = false;
  Stream<PossitionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PossitionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PossitionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer()
      ..setUrl(
        // "https://assets.mixkit..co/music/preview/mixkit-trip-hop-vibes-149.mp3"
        BlocProvider.of<LocaleCubit>(context).currentLangCode ==
                AppStrings.englishCode
            ? widget.entity.audio_En
            : widget.entity.audio_Ar,
      );
    _audioPlayer.positionStream;
    _audioPlayer.bufferedPositionStream;
    _audioPlayer.durationStream;
    _changeView();
  }

  bool isShowCaros = true;
  void _changeView() {
    setState(() {
      isShowCaros = !isShowCaros;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isShowCaros
            ? SizedBox(
                height: context.height * 0.35,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(BlocProvider.of<LocaleCubit>(context)
                                      .currentLangCode ==
                                  AppStrings.englishCode
                              ? widget.entity.descriptionEN
                              : widget.entity.descriptionAR
                          // style: TextStyle(
                          //   fontSize: 18,
                          // overflow: TextOverflow.ellipsis,
                          // ),
                          // maxLines: 5,
                          ),
                    ),
                  ),
                ),
              )
            : Caros(context, widget.entity),
        SizedBox(
          height: context.height * 0.01,
        ),
        StreamBuilder<PossitionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            return Padding(
              padding: const EdgeInsetsDirectional.only(start: 12, end: 12),
              child: ProgressBar(
                barHeight: 8,
                baseBarColor: Colors.grey[600],
                bufferedBarColor: Colors.grey,
                progressBarColor: Color.fromARGB(255, 221, 171, 239),
                timeLabelTextStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
                thumbColor: Colors.blue,
                progress: positionData?.position ?? Duration.zero,
                buffered: positionData?.bufferedPosition ?? Duration.zero,
                total: positionData?.duration ?? Duration.zero,
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              width: context.width * 1,
              height: context.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,
              ),
              // ignore: dead_code
              child: ElevatedButton(
                style: ButtonStyle(
                  //padding: EdgeInsets.all(10.0),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue,
                    // Color.fromARGB(255, 221, 171, 239),
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
                onPressed: () {
                  _changeView();
                },
                child: AutoSizeText(
                  isShowCaros
                      ? AppLocalizations.of(context)!.translate("return")!
                      : AppLocalizations.of(context)!.translate("readText")!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              )),
        )

        // slider(),
        // InkWell(
        //   onTap: () {
        //     getAudio();
        //   },
        //   child: Icon(
        //     playing == false
        //         ? Icons.play_circle_outline
        //         : Icons.pause_circle_outline,
        //     size: 100,
        //     color: Colors.black,
        //   ),
        // )
      ],
    );
  }

  // Widget slider() {
  //   return Slider.adaptive(
  //       min: 0.0,
  //       value: possiton.inSeconds.toDouble(),
  //       max: duration.inSeconds.toDouble(),
  //       onChanged: ((value) {
  //         setState(() {});
  //       }));
  // }

  // void getAudio() async {
  //   var url =
  //       "https://assets.mixkit..co/music/preview/mixkit-trip-hop-vibes-149.mp3";

  //   //playying is false by default
  //   if (playing) {
  //     //pause song
  //     var res = await _audioPlayer.pause();
  //     if (res == 1) {
  //       setState(() {
  //         playing == false;
  //       });
  //     }
  //   } else {
  //     //  play song

  //     var res = await audioPlayer.play(url, isLocal: true);
  //     if (res == 1) {
  //       setState(() {
  //         playing == true;
  //       });
  //     }
  //   }
  // }
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

Widget Caros(context, GetPlacesEntities entity) {
  return CarouselSlider(
      items: entity.images.map(
        (e) {
          final bool isLocalImage =
              e.url.contains('http://localhost/storage/') || e.url.isEmpty;
          return isLocalImage
              ? Container()
              : Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: flutter.Image(
                    height: double.infinity / 2,
                    width: double.infinity,
                    image: NetworkImage(e.url),
                    fit: BoxFit.fill,
                  ),
                );
        },
      ).toList(),
      options: CarouselOptions(
          height: 200,
          initialPage: 0,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          scrollDirection: Axis.horizontal));
}

class CarouselModel {
  final String imageUrl;

  CarouselModel({
    required this.imageUrl,
  });
}

List<CarouselModel> carouselModel = [
  CarouselModel(
    imageUrl:
        "https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg",
  ),
  CarouselModel(
    imageUrl:
        "https://thumbs.dreamstime.com/b/green-planet-your-hands-save-earth-environment-concept-green-planet-your-hands-environment-concept-116939326.jpg",
  ),
  CarouselModel(
    imageUrl:
        "https://thumbs.dreamstime.com/b/green-field-blue-sky-environment-infinity-concept-50639917.jpg",
  )
];

class PossitionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PossitionData(this.position, this.bufferedPosition, this.duration);
}
