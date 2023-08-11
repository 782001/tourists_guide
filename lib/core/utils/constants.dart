// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';



// const Color kPrimaryColor = Color(0xFF079992);
// final Color kAccentColor = Color(0xFF1E3799);
// final Color kBlueColor = Color(0xFF00104E);
// const Color kGreyColor = Color(0xFFE2E5F1);
// final Color kDarkGreyColor = Color(0xFF727272);
// final Color kRedColor = Color(0xFFD53030);
// final Color kWhiteColor = Colors.white;
// final Color kBlackColor = Colors.black;


// ThemeData theme = ThemeData(
//   platform: TargetPlatform.iOS,
//   primaryColor: kPrimaryColor,
//   canvasColor: Color(0XFFF8F9FD),
//   fontFamily: 'Rta',
//   // appBarTheme: AppBarTheme(
//   //   backgroundColor: kPrimaryColor,
//   //   iconTheme: IconThemeData(color: Colors.white),
//   // ),
//   textButtonTheme: TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all(kPrimaryColor)),),
//   colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
// );

// String convertSecondsIntoTime(int seconds) {
//   Duration duration = Duration(seconds: seconds);
//   return "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds - (duration.inMinutes * 60)).toString().padLeft(2, '0')}";
// }

// void closeKeyboard() => FocusScope.of(RouteManager.currentContext).requestFocus(FocusNode());

// TextTheme get getTextTheme => Theme.of(RouteManager.currentContext).textTheme;

// double sizeFromHeight(double fraction,
//     {bool removeAppBarSize = true}) {
//   MediaQueryData mediaQuery = MediaQuery.of(RouteManager.currentContext);
//   fraction = (removeAppBarSize
//       ? (mediaQuery.size.height -
//       AppBar().preferredSize.height -
//       mediaQuery.padding.top)
//       : (mediaQuery.size.height - mediaQuery.viewPadding.top)) /
//       (fraction == 0 ? 1 : fraction);
//   return fraction;
// }

// double sizeFromWidth(double fraction) {
//   fraction = MediaQuery.of(RouteManager.currentContext).size.width / (fraction == 0 ? 1 : fraction);
//   return fraction;
// }

// String getAsset(String imageName) => 'assets/images/$imageName.png';

// String getLottie(String lottie) => 'assets/lottie/$lottie.json';

// //
// const String MAP_API_KEY = 'AIzaSyAdvXvIQSrguEjx4zPLkjxCYJDYK-tBIrE';
// //
// // // const LatLng DEFAULT_LAT_LNG = LatLng(24.7136, 46.6753);
// //
// // const double DEFAULT_MAP_ZOOM = 14.0;
// //
// // const int PAGINATE_BY = 10;
// //
// // const DefaultErrorMessage = 'خطأ في الانترنت!';
// //

// //
// // // Future<BitmapDescriptor> getMapIcon(String imageName) =>
// // //     BitmapDescriptor.fromAssetImage(
// // //       ImageConfiguration(size: Size(100, 100)),
// // //       getAsset('enabled-marker'),
// // //     );
// //
// // void showInternetErrorMessage ()=> showToast(DefaultErrorMessage, color: Colors.red);
// //
// // double get gridViewChildRatio => sizeFromWidth(1.0) / sizeFromHeight(1.5);
// //
// // SliverGridDelegate get gridViewDelegate => SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: gridViewChildRatio,crossAxisSpacing: 15,mainAxisSpacing: 15);
// //
// // const List<String> daysList = ['الاحد','الاثنين','الثلاثاء','الاربعاء','الخميس'];
// //
// // // String replaceArabicNumber(String input) {
// // //   if(!input.contains('٥')) return input;
// // //   const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
// // //   const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
// // //
// // //   for (int i = 0; i < english.length; i++) {
// // //     input = input.replaceAll(arabic[i], english[i]);
// // //   }
// // //   return input;
// // // }
// //
// // // String replaceSpecialCharacterFromPhone(String value){
// // //   return value.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', '').trim();
// // // }
// //
// // // String convertToPhoneNumber(String phoneNumber){
// // //   if(phoneNumber.startsWith('+'))
// // //     phoneNumber = phoneNumber.replaceFirst('+', '00');
// // //   if(phoneNumber.startsWith('5'))
// // //     phoneNumber = '00966' + phoneNumber;
// // //   else if(phoneNumber.startsWith('05'))
// // //     phoneNumber = '00966' + phoneNumber.replaceFirst('0', '');
// // //   else if (phoneNumber.startsWith('966'))
// // //     phoneNumber = '00' + phoneNumber;
// // //   return phoneNumber.trim();
// // // }
// //
// // // bool isSaudiNumber(String value){
// // //   if(value.startsWith('+9665') && value.length == 13)
// // //     return true;
// // //   else if(value.startsWith('5') && value.length == 9)
// // //     return true;
// // //   else if(value.startsWith('05') && value.length == 10)
// // //     return true;
// // //   else if (value.startsWith('009665') && value.length == 14)
// // //     return true;
// // //   else if (value.startsWith('9665') && value.length == 12)
// // //     return true;
// // //   else
// // //     return false;
// // // }
// //
// // // bool isMessageAPhoneNumber(String message){
// // //   final trimmedMessage = message.trim();
// // //   bool value = false;
// // //   if((trimmedMessage.startsWith('+966') && trimmedMessage.length == 13) || (trimmedMessage.startsWith('00966') && trimmedMessage.length == 14) || (trimmedMessage.startsWith('966') && trimmedMessage.length == 12) || (trimmedMessage.startsWith('05') && trimmedMessage.length == 10) || (trimmedMessage.startsWith('5') && trimmedMessage.length == 9))
// // //     value = true;
// // //   else if((trimmedMessage.startsWith('+٩٦٦') && trimmedMessage.length == 13) || (trimmedMessage.startsWith('٠٠٩٦٦') && trimmedMessage.length == 14) || (trimmedMessage.startsWith('٩٦٦') && trimmedMessage.length == 12) || (trimmedMessage.startsWith('٠٥') && trimmedMessage.length == 10) || (trimmedMessage.startsWith('٥') && trimmedMessage.length == 9))
// // //     value = true;
// // //   return value;
// // // }
// // //
// // // bool isMessageALink(String message){
// // //   bool value = false;
// // //   if (message.contains('http:') || message.contains('https:') || message.contains('www.') || message.contains('.com') || message.contains('.net') || message.contains('.org') || message.contains('.sa') || message.contains('.eg'))
// // //     value = true;
// // //   return value;
// // // }
// //
// // // String getExtension(String file){
// // //   if(file.isEmpty) return '';
// // //   var fileName = (file.split('/').last);
// // //   String imageExtension = fileName.split('.').last.toLowerCase().replaceAll('}', '');
// // //   return imageExtension;
// // // }
// //
// bool isDebugVersion = false;

// Future<void> getVersionStatus() async {
//   try {
//     final response = await Dio().get('https://suhailonline-43730-default-rtdb.firebaseio.com/production.json');
//     isDebugVersion = !response.data;
//   } catch (e) {}
// }

// String priceStatementFromFirebase = '';
// Future<String> getPriceStatementFromFirebase() async {
//   try {
//     final response = await Dio().get('https://suhailonline-43730-default-rtdb.firebaseio.com/price.json');
//     priceStatementFromFirebase = response.data;
//     return response.data;
//   } catch (e) {}
//   priceStatementFromFirebase = '';
//   return '';
// }

// Map<String, dynamic> getParamFromURL(String url) {
//   final uri = Uri.parse(url);
//   Map<String, dynamic> data = {};
//   uri.queryParameters.forEach((key, value) {
//     data[key] = value;
//   });
//   return data;
// }

// String reformatTime(TimeOfDay value){
//   final reformatted = value.hour.toString().padLeft(2,'0') + ':' + value.minute.toString().padLeft(2,'0') + ':00';
//   return reformatted;
// }

// String reformatDate(DateTime? value){
//   if(value == null) return '';
//   final reformatted = value.year.toString() + '-' + value.month.toString().padLeft(2,'0') + '-' + value.day.toString().padLeft(2,'0');
//   return reformatted;
// }

// String get getCurrentTimeCustomized {
//   final now = TimeOfDay.now();
//   final time = '${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:00';
//   return time;
// }

// String get getTodayDateCustomized {
//   final now = DateTime.now();
//   final date = '${now.year}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}';
//   return date;
// }
// //
// // // String getFileNameFromURL(String url, String symbol) => url.substring(url.lastIndexOf(symbol) + 1);
// //
// //
// // // final containerDecoration = BoxDecoration(
// // //     borderRadius: BorderRadius.circular(10),
// // //     color: Colors.white,
// // //     border: Border.all(color: Colors.black54, width: 0.2));
// //
