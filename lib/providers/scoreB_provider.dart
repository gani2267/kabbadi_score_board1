import 'package:flutter/material.dart';

class ScoreBCounter with ChangeNotifier{
  int _scoreB = 0;

  int get scoreB => _scoreB;

  void increment(int num){
    _scoreB+=num;
    notifyListeners();
  }
}

class SpinnerB with ChangeNotifier{
  int _value = 3;

  int get value => _value;

  void giveValue(int num){
    _value=num;
    notifyListeners();
  }
}

class teamB with ChangeNotifier{
  int _playerNo = 7;

  int get playerNo => _playerNo;

  void giveValue(int num){
    _playerNo=num;
    notifyListeners();
  }

  void decrement(int i) {
    _playerNo -= i;
  }
}