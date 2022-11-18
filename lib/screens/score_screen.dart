import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kabbadi_score_board/providers/timer_provider.dart';
import 'package:kabbadi_score_board/widgets/customPlayer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:riverpod/riverpod.dart';

import '../components/compo.dart';
import '../providers/global_provider.dart';
import '../styles.dart';

class ScoreScreen extends StatefulWidget {
  ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late TextEditingController controller;
  late TextEditingController controller_2;
  static StreamDuration _streamDuration= StreamDuration(
    const Duration(minutes: 40),
  );

  final _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(40), // millisecond => minute.
  );

  @override
  void initState() {
    super.initState();
    controller= TextEditingController();
    controller_2=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _btnWidth = (_size.width-60)/2;

    int _spinnerA = context.read<global_provider>().spinnervalueA;
    int _spinnerB = context.read<global_provider>().spinnervalueB;
    bool _isTimerPause = false;

    int _playerTeamB = context.read<global_provider>().playerinB;
    int _playerTeamA = context.read<global_provider>().playerinA;
    double _percentEmptyRaidA = 0;
    double _percentEmptyRaidB = 0;
    return Consumer<global_provider>(
        builder: (BuildContext context, gp, Widget? child) {
    return SingleChildScrollView(
      child: Column(
        children: [

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kbButton(width: 100, title:
                        "START", onTap: () =>
                        {
                          if(_stopWatchTimer.isRunning){
                            _stopWatchTimer.onStopTimer()
                          }else{
                            _stopWatchTimer.onStartTimer()
                          }
                        }, btnColor: Colors.blue),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: [
                    StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                      initialData: 0,
                      builder: (context, snap) {
                        final value = snap.data;
                        final displayTime = StopWatchTimer.getDisplayTime(value!);
                        String _displayTimeArrMid = displayTime.split('.').first;
                        List<String> _displayTimeArr = _displayTimeArrMid.split(':');
                        return Row(
                          children: <Widget>[
                            Icon(Icons.timer),
                            SizedBox(
                              width: 2,
                            ),
                            Text(_displayTimeArr[1]+":"),
                            Text(_displayTimeArr[2])
                          ],
                        );
                      },
                    ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  kbButton(width: 100, title: "RESET", onTap: () =>
                  {
                    _stopWatchTimer.onResetTimer()
                  }, btnColor: Colors.blue),
                ],
              ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () async {
                      final TA= await openDialog();
                      if(TA==null || TA.isEmpty) return;
                      setState(() => gp.changeTeamAName(TA));
                    },
                    child: Text(gp.teamAname,style: headline5WhiteBold,),
                  ),
                  Container(
                    child: giveHeadAsNo(no_of_players: gp.playerinA),
                  ),
                  SizedBoxBtwBtns(),
                  Text('${gp.scoreA}',style: headline1,),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "BONUS LINE", onTap: ()=>{
                    gp.incrementA(1),
                    _percentEmptyRaidA = 0,
                    gp.addHistoryEle(gp.teamAname, 'BonusLine: +1')
                  }),
                  SizedBoxBtwBtns(),
                  GestureDetector(
                    child: new LinearPercentIndicator(
                      width: _btnWidth,
                      barRadius: Radius.circular(10),
                      animation: true,
                      animationDuration: 000,
                      lineHeight: 40.0,
                      percent: _percentEmptyRaidA,
                      center: Text("EMPTY RAID",style: TextStyle(
                        color: Colors.black
                      ),),
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.red,
                    ),
                    onTap: () {
                      gp.incrementA(0);
                      gp.addHistoryEle(gp.teamAname, 'Empty Raid: +0');
                      _percentEmptyRaidA += (1/3);
                      Timer(Duration(seconds: 0), () {
                        if(_percentEmptyRaidA == 1){
                          gp.undoHistoryEle();

                          _percentEmptyRaidA = 0;

                          if(gp.playerinB <=3){
                            gp.incrementA(2);
                          }else{
                            gp.incrementB(1);
                          }
                          gp.incrementplayerB(1);
                          gp.addHistoryEle(gp.teamAname, 'Raider out Do or Die raid');

                        }
                      });
                    },
                  ),
                  // kbButton(width: _btnWidth, title: "EMPTY RAID", onTap: ()=>{
                  //   gp.incrementA(0),
                  //   gp.addHistoryEle(gp.teamAname, 'Empty Raid: +0')
                  // }),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+1", onTap: ()=>{
                    gp.incrementA(1),
                    gp.incrementplayerA(1),
                    gp.addHistoryEle(gp.teamAname, 'Raid:+1'),
                  _percentEmptyRaidA = 0
                    }
                  ),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+2", onTap: ()=>{
                    gp.incrementA(2),
                    gp.incrementplayerA(2),
                    _percentEmptyRaidA = 0,
                    gp.addHistoryEle(gp.teamAname, 'Raid: +2')
                  }),
                  SizedBoxBtwBtns(),
                  Row(
                    children: [
                      kbButton(width: _btnWidth-50, title: "RAID:${gp.spinnervalueA}",
                          onTap: ()=>{gp.givespinnerValueA(_spinnerA),
                            gp.incrementA(_spinnerA),
                            gp.incrementplayerA(_spinnerA),
                            _percentEmptyRaidA = 0,
                            gp.addHistoryEle(gp.teamAname, 'Raid: +${_spinnerA}')
                      }),
                      DropdownButton(
                          dropdownColor: morpic,
                          borderRadius: BorderRadius.circular(10),
                          items: [
                            DropdownMenuItem(child: Text("+3"),value: 3),
                            DropdownMenuItem(child: Text("+4"),value: 4,),
                            DropdownMenuItem(child: Text("+5"),value: 5),
                            DropdownMenuItem(child: Text("+6"),value: 6,),
                            DropdownMenuItem(child: Text("+7"),value: 7),
                          ],
                          onChanged: (value) {

                            gp.givespinnerValueA(value!);
                            _spinnerA=value!;

                            //context.read<SpinnerA>().giveValue(value!);
                          }),
                    ],
                  ),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "DEFEND", btnColor: morpic, onTap: ()=>{
                  _percentEmptyRaidB = 0,
                    if(gp.playerinA <=3){
                      gp.incrementA(2),
                      gp.incrementplayerA(1),
                      gp.addHistoryEle(gp.teamAname, 'Super Tackel: +2')
                    }else
                      {
                        gp.incrementA(1),
                        gp.incrementplayerA(1),
                        gp.addHistoryEle(gp.teamAname, 'Tackel: +1')
                      }

                  }),
                  SizedBoxBtwBtns(),
                ],
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () async {
                      final TB= await OD();
                      if(TB==null || TB.isEmpty) return;
                      setState(() => gp.changeTeamBName(TB));
                    },
                    child: Text(gp.teamBname,style: headline5WhiteBold,),
                  ),
                  Container(
                    child: giveHeadAsNo(no_of_players: gp.playerinB),
                  ),
                  SizedBoxBtwBtns(),
                  Text('${gp.scoreB}',style: headline1,),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "BONUS LINE", onTap: ()=>{gp.incrementB(1),
                  _percentEmptyRaidB = 0,
                    gp.addHistoryEle(gp.teamBname, 'BonusLine: +1')
                  }),
                  SizedBoxBtwBtns(),
                  GestureDetector(
                    child: new LinearPercentIndicator(
                      width: _btnWidth,
                      barRadius: Radius.circular(10),
                      animation: true,
                      animationDuration: 000,
                      lineHeight: 40.0,
                      percent: _percentEmptyRaidB,
                      center: Text("EMPTY RAID",style: TextStyle(
                          color: Colors.black
                      ),),
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.red,
                    ),
                    onTap: () {
                      gp.incrementB(0);
                      gp.addHistoryEle(gp.teamBname, 'Empty Raid: +0');
                      _percentEmptyRaidB += (1/3);
                      Timer(Duration(seconds: 0), () {
                        if(_percentEmptyRaidB == 1){
                          gp.undoHistoryEle();
                          _percentEmptyRaidB = 0;
                          if(gp.playerinA <=3){
                            gp.incrementA(2);
                          }else{
                            gp.incrementA(1);
                          }
                          gp.incrementplayerA(1);
                          gp.addHistoryEle(gp.teamBname, 'Raider out Do or Die raid');

                        }

                      });
                    },
                  ),
                  // kbButton(width: _btnWidth, title: "EMPTY RAID", onTap: ()=>{
                  //   gp.incrementB(0),
                  //   gp.addHistoryEle(gp.teamBname, 'Empty Raid: +0')
                  // }),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+1", onTap: ()=>{gp.incrementB(1),
                    gp.incrementplayerB(1),
                    _percentEmptyRaidB= 0,
                    gp.addHistoryEle(gp.teamBname, 'Raid: +1')
                  }),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+2", onTap: ()=>{gp.incrementplayerB(2),

                  gp.incrementB(2),
                  _percentEmptyRaidB = 0,
                    gp.addHistoryEle(gp.teamBname, 'Raid: +2')

                  }),
                  SizedBoxBtwBtns(),
                  Row(
                    children: [
                      kbButton(width: _btnWidth-50, title: "RAID:${gp.spinnervalueB}",
                          onTap: ()=>{
                        gp.givespinnerValueB(_spinnerB),
                            gp.incrementB(gp.spinnervalueB),
                            gp.incrementplayerB(gp.spinnervalueB),
                              _percentEmptyRaidB = 0,
                            gp.addHistoryEle(gp.teamBname, 'Raid: +${gp.spinnervalueB}')
                      }),
                      DropdownButton(
                          dropdownColor: morpic,
                          borderRadius: BorderRadius.circular(10),
                          items: [
                            DropdownMenuItem(child: Text("+3"),value: 3),
                            DropdownMenuItem(child: Text("+4"),value: 4,),
                            DropdownMenuItem(child: Text("+5"),value: 5),
                            DropdownMenuItem(child: Text("+6"),value: 6,),
                            DropdownMenuItem(child: Text("+7"),value: 7),
                          ],
                          onChanged: (value) {
                           gp.givespinnerValueB(value!);
                           _spinnerB = value!;
                            // context.read<SpinnerB>().giveValue(value!);
                          }),
                    ],
                  ),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "DEFEND", btnColor: morpic, onTap: ()=>{
                    _percentEmptyRaidA = 0,
                    if(gp.playerinB<=3){
                      gp.incrementA(2),
                      _percentEmptyRaidA = 0,
                      gp.incrementplayerB(1),
                      gp.addHistoryEle(gp.teamBname, 'Super Tackel: +2')

                    }

                    else{
                      gp.incrementplayerB(1),
                      gp.incrementB(1),
                      gp.addHistoryEle(gp.teamBname, 'Tackel: +1')

                    }

                  }),
                  SizedBoxBtwBtns(),
                ],
              ),
            ],
          ),
          CupertinoButton.filled(
            onPressed: () {
              gp.undoHistoryEle();
            },
            child: Text(
              "UNDO",
            ),
          ),
        ],
      ),

    );
        }
    );
  }

  Dialog changeTeamNameDialog= Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
    backgroundColor: Colors.white,
    child: Container(
      height: 300.0,
      width: 300.0,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text('TEAM A :', style: TextStyle(color: Colors.red),),
          ),
          Padding(
            padding:  EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: TextFormField(
            ),
          ),
          Padding(
            padding:  EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text('TEAM B :', style: TextStyle(color: Colors.red),),
          ),
          // Padding(
          //   padding: EdgeInsets.all(15.0),
          //   child: Text('Awesome', style: TextStyle(color: Colors.red),),
          // ),
          // Padding(padding: EdgeInsets.only(top: 50.0)),
          TextButton(onPressed: () {

          },
              child: CupertinoButton.filled(
                onPressed: () {},
                child: Text(
                  "SAVE",
                ),
              ),)
        ],
      ),
    ),
      );

  Future<String?> openDialog() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Your Team Name'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: 'Team A'),
        controller: controller,
      ),
      actions: [
        TextButton(onPressed: submit,
          child: Text('SUBMIT'),
        ),

      ],
    ),
  );
  Future<String?> OD() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Your Team Name'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: 'Team B'),
        controller: controller_2,
      ),
      actions: [
        TextButton(onPressed: sb,
          child: Text('SUBMIT'),
        ),

      ],
    ),
  );
  void sb(){
    Navigator.of(context).pop(controller_2.text);
  }
  void submit(){
    Navigator.of(context).pop(controller.text);

  }
}
