import 'package:flutter/material.dart';

class ExampleProvider extends ChangeNotifier {
  int _count = 0;

  increase() {
    _count++;
  }

  get getCount => _count;
}
