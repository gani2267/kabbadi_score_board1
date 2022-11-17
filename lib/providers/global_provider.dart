import 'package:flutter/material.dart';
import 'package:kabbadi_score_board/utils/history_element.dart';


class global_provider with ChangeNotifier{
  int _scoreA = 0;

  int get scoreA => _scoreA;

  void incrementA(int num){
    _scoreA+=num;
    notifyListeners();
  }
  int _scoreB =0;
  int get scoreB=>_scoreB;
  void incrementB(int num){
    _scoreB+=num;
    notifyListeners();
  }


  int _players_in_A=7;
  int _players_in_B=7;

  int get playerinA=>_players_in_A;
  int get playerinB=>_players_in_B;
  void incrementplayerA(int num){
    _players_in_A += num;
    if(_players_in_A>=7){
      _players_in_A = 7;
    }
    _players_in_B-=num;
    if(_players_in_B<=0){
      _players_in_B=7;
    }
    notifyListeners();
  }
  void decrementplayerA(int num){
    _players_in_A-=num;
    if(_players_in_A<=0){
      _players_in_A=7;
    }
    _players_in_B+=num;
    if(_players_in_B>=7){
      _players_in_B=7;
    }
    notifyListeners();
  }

  void incrementplayerB(int num){
    _players_in_B += num;
    if(_players_in_B>=7){
      _players_in_B = 7;
    }
    _players_in_A-=num;
    if(_players_in_A<=0){
      _players_in_A=7;
    }
    notifyListeners();
  }
  void decrementplayerB(int num){
    _players_in_A-=num;
    if(_players_in_A<=0){
      _players_in_A=7;
    }
    _players_in_B+=num;
    if(_players_in_B>=7){
      _players_in_B=7;
    }
    notifyListeners();
  }




  int _spinnervalueA = 3;

  int get spinnervalueA => _spinnervalueA;

  void givespinnerValueA(int num){
    _spinnervalueA=num;
    notifyListeners();
  }

  int _spinnervalueB = 3;

  int get spinnervalueB => _spinnervalueB;

  void givespinnerValueB(int num){
    _spinnervalueB=num;
    notifyListeners();
  }


  List<HistoryElement> _historylist = [];

  List get historylist => _historylist;

  void addHistoryEle(String teamName,String msg){
    HistoryElement ele = new HistoryElement(teamName, msg, _scoreA, _scoreB,_players_in_A,_players_in_B);
    _historylist.add(ele);
    notifyListeners();
  }

  void undoHistoryEle(){
    _historylist.removeLast();
    HistoryElement temp = _historylist.last;
    _scoreA = temp.teamAscore;
    _scoreB = temp.teamBscore;
    _players_in_A = temp.teamAplayerNo;
    _players_in_B = temp.teamBplayerNo;
  }

}
