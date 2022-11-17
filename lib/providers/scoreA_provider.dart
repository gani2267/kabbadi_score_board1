import 'package:flutter/material.dart';

class ScoreACounter with ChangeNotifier{
  int _scoreA = 0;

  int get scoreA => _scoreA;

  void increment(int num){
    _scoreA+=num;
    notifyListeners();
  }
}

class SpinnerA with ChangeNotifier{
  int _value = 3;

  int get value => _value;

  void giveValue(int num){
    _value=num;
    notifyListeners();
  }
}

class teamA with ChangeNotifier{
  int _playerNo = 7;

  int get playerNo => _playerNo;

  void giveValue(int num){
    _playerNo=num;
    notifyListeners();
  }
}