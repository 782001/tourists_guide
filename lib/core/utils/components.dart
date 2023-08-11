import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color DefaultColor = Colors.teal;
void NavTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (contex) => Widget));

void NavAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);
Widget OutLineButton(
  String? text,
  String? icon,
) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)),
      border: Border.all(color: const Color(0xff04685C), width: 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          text!,
          style: const TextStyle(color: Color(0xff04685C)),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 30,
          height: 30,
          child: Image.asset(
            icon!,
          ),
        ),
      ],
    ),
  );
}

class OutLineB extends StatelessWidget {
  const OutLineB({super.key, this.text, this.icon});
  final String? text;
  final String? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      // height: context.height * .073,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.7),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)),
        // border: Border.all(color: Color.fromARGB(255, 221, 171, 239), width: 3),
      ),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Image.asset(
          icon!,
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}

// Widget OrDevider() => Row(
//       children: [
//         Expanded(
//           child: Container(
//             color: Colors.grey[200],
//             height: 1,
//           ),
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//          Text(
//            AppLocalizations.of(context)!
//                                           .translate('password')!,
//           style: TextStyle(
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//         Expanded(
//           child: Container(
//             color: Colors.grey[200],
//             height: 1,
//           ),
//         ),
//       ],
//     );

void ShowToust({
  required String Text,
  required ToustStates state,
}) =>
    Fluttertoast.showToast(
        msg: Text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToustColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToustStates { SUCSESS, ERROR, WARNNING }

Color ChooseToustColor(ToustStates state) {
  Color color;
  switch (state) {
    case ToustStates.SUCSESS:
      color = Colors.green;
      break;
    case ToustStates.ERROR:
      color = Colors.red;
      break;
    case ToustStates.WARNNING:
      color = Colors.amber;
      break;
  }
  return color;
}

String? uId = '';
