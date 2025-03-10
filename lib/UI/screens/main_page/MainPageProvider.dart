import 'package:flutter/material.dart';

class MainPageProvider extends ChangeNotifier {
  int pageIndex = 0;

  void changePageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }
}
