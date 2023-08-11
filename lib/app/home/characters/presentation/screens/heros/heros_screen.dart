import 'package:auto_size_text/auto_size_text.dart';
import 'package:tourist_guide/core/utils/app_strings.dart';
import 'package:tourist_guide/core/utils/assets_images_path.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/locale/app_localizations.dart';
import '../../../../../localization/presentation/cubit/locale_cubit.dart';
import '../../../domain/entity/get_characters_entities.dart';
import '../../controller/characters_cubit.dart';
import '../../controller/characters_states.dart';
import 'heros_details.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HerosScreen extends StatelessWidget {
  const HerosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios_new,
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
      body: BlocConsumer<CharactersCubit, CharactersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = CharactersCubit.get(context);
            return ConditionalBuilder(
              condition:
                  CharactersCubit.get(context).getCharactersEntities != null,
              builder: (context) => Center(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  width: context.width * .9,
                  height: context.height * .85,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      // crossAxisCount: 3,
                      // mainAxisSpacing: 1,
                      // crossAxisSpacing: 1,
                      // childAspectRatio: 1 / 1.7,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: context.width * 0.05,
                        mainAxisSpacing: context.width * 0.1,
                        mainAxisExtent: context.height * 0.4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        int TouchIndex = HeroList[index].id;
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HerosDetails(
                                            charactersData: cubit
                                                .getCharactersEntities![index],

                                            TouchIndex: TouchIndex,
                                            // heroIconsModel: HeroIconModel,
                                          )));
                            },
                            child: HeroGridView(
                                cubit.getCharactersEntities![index],
                                context,
                                TouchIndex));
                      },
                      itemCount: cubit.getCharactersEntities!.length,
                      // itemCount: 3,
                      // children: List.generate(HeroList.length,
                      //     (index) => HeroGridView(HeroList[index], context)),
                    ),
                  ),
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }
}

class HeroIconsModel {
  final String icon;
  final String title;
  final int id;

  HeroIconsModel({
    required this.icon,
    required this.title,
    required this.id,
  });
}

List<HeroIconsModel> HeroList = [
  HeroIconsModel(icon: homeImage, title: "Athena", id: 1),
  HeroIconsModel(icon: homeImage, title: 'Asclepius', id: 2),
  HeroIconsModel(icon: homeImage, title: 'Aphrodite', id: 3),
  HeroIconsModel(icon: homeImage, title: 'Zeus ', id: 4),
  HeroIconsModel(icon: homeImage, title: 'Athena', id: 5),
  HeroIconsModel(icon: homeImage, title: 'Asclepius', id: 6),
  HeroIconsModel(icon: homeImage, title: 'Athena', id: 7),
];
HeroGridView(
  GetCharactersEntities HeroIconModel,
  BuildContext context,
  int TouchIndex,
) {
  final bool isLocalImage =
      HeroIconModel.image.contains('http://localhost/storage/') ||
          HeroIconModel.image.isEmpty;
  // final bool isNullImage = HeroIconModel.image.contains('');
  return Container(
    // height: context.height * 0.5,
    // width: context.width * 0.4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey, width: 2),
      color: Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Container(
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        //   ),
        //   child: Image.asset(
        //     HeroIconModel.icon,
        //     height: context.height * 0.2,
        //     width: context.width * .7,
        //     fit: BoxFit.fill,
        //   ),
        // ),
        Container(
          height: context.height * 0.3,
          width: context.width * 8,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: isLocalImage
                ? Image(
                    image: AssetImage(
                      homeImage,
                    ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image(
                    image: NetworkImage(
                      HeroIconModel.image,
                    ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            // Image.asset(
            //   HeroIconModel.image,
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
        SizedBox(
          height: context.height * 0.013,
        ),
        Center(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: context.height * 0.08,
              width: context.width * .3,
              child: Center(
                child: Text(
                  BlocProvider.of<LocaleCubit>(context).currentLangCode ==
                          AppStrings.englishCode
                      ? HeroIconModel.nameEn
                      : HeroIconModel.nameAr,
                  style: const TextStyle(
                      color: Colors.black,
                      // fontSize: context.height * 0.017,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
