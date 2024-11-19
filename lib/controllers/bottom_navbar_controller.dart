import 'package:get/get.dart';

class BottomnavbarController extends GetxController {
  var selectedIndex = 0.obs;

  void changedTabIndex(int index) {
    selectedIndex.value = index;
  }
}