import 'dart:async';

import 'package:flutter/material.dart';

class TimeStrings with ChangeNotifier{
  String _startbtn  = "START";
  String _resetbtn = "RESET";
  String get startbtn => _startbtn;
  bool _pause = false;
  bool _start = true;

  void changeValue(bool pause){
    _pause = pause;
    if(pause){
      _startbtn = "PAUSE";
    }else{
      _startbtn = "START";
    }
    notifyListeners();
  }

  int _min = 40;
  int _second = 00;

  int get min => _min;
  int get second =>_second;

  void timer(pause){
    int totalTime = _min*60 + _second;
    notifyListeners();
  }

  void ResetTime(reset){
    _min =40;
    _second = 0;
    notifyListeners();
  }

  // void starttimer(start){
  //   while(min <= 40)
  //     while(min >= 0)
  //        = min;
  //
  //
  //
  // }
}