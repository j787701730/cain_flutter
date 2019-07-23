import 'package:flutter/material.dart';

class ProviderModel with ChangeNotifier {
  int _count = 0;

  int get value => _count;

  Color _color = Colors.red;

  Color get color => _color;

  // 状态栏的背景图
  String _topBackground = 'title_bar_bg.jpg';

  String get topBackground => _topBackground;

  void increment() {
    _count++;
    notifyListeners();
  }

  void changeColor(color) {
    _color = color;
    notifyListeners();
  }

  void changeTopBackground({bg: 'title_bar_bg.jpg'}) {
    _topBackground = bg;
    notifyListeners();
  }
}
