const String imageAssetsRoot = "assets/images/";
const String iconAssetsRoot = "assets/icons/";

String down = _getAssetsImagePath('down.png');
String west = _getAssetsImagePath('west.png');
String shalal = _getAssetsImagePath('Head.png');
String ret = _getAssetsImagePath('M-removebg-preview.png');
String marakis = _getAssetsImagePath('location.png');
String practice = _getAssetsImagePath('respect.png');
String cold = _getAssetsImagePath('cold.png');
String colding = _getAssetsImagePath('cool.png');
String heart = _getAssetsImagePath('heart.jpeg');
String exIcon = _getAssetsImagePath('ex.png');
String loginImage = _getAssetsImagePath('login.png');
String googleImage = _getAssetsImagePath('google.png');
String faceImage = _getAssetsImagePath('facebook.png');
String homeImage = _getAssetsImagePath('homeImage.jpg');
String homeImage2 = _getAssetsImagePath('homeImage2.jpg');

String _getAssetsImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}

String _getAssetsIconPath(String fileName) {
  return iconAssetsRoot + fileName;
}
