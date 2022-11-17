import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kabbadi_score_board/providers/timer_provider.dart';
import 'package:kabbadi_score_board/widgets/customPlayer.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
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
  static StreamDuration _streamDuration= StreamDuration(
    const Duration(minutes: 40),
  );

  @override
  void initState() {

    super.initState();
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
                          // _isTimerPause = !_isTimerPause,
                          // gp.changeValue(_isTimerPause),
                          // gp.timer(!_isTimerPause),
                          // _streamDuration.pause(),
                        }, btnColor: Colors.blue),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: [
                        SlideCountdownSeparated(duration:
                        Duration(minutes: context.watch<TimeStrings>().min,
                            seconds: context.watch<TimeStrings>().second),
                        )
                        // Icon(Icons.timer),
                        // SizedBox(
                        //   width: 2,
                        // ),
                        // Text(context
                        //     .watch<TimeStrings>()
                        //     .min
                        //     .toString()+":"),
                        // Text(context
                        //     .watch<TimeStrings>()
                        //     .second
                        //     .toString()),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  kbButton(width: 100, title: "RESET", onTap: () =>
                  {
                    context.watch<TimeStrings>().ResetTime(),
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
                    onPressed: () { },
                    child: Text('Team A',style: headline5WhiteBold,),
                  ),
                  Container(
                    child: giveHeadAsNo(no_of_players: gp.playerinA),
                  ),
                  SizedBoxBtwBtns(),
                  Text('${gp.scoreA}',style: headline1,),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "BONUS LINE", onTap: ()=>{gp.incrementA(1)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "EMPTY RAID", onTap: ()=>{gp.incrementA(0)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+1", onTap: ()=>{
                    gp.incrementA(1),
                    gp.incrementplayerA(1)
                    }
                  ),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+2", onTap: ()=>{
                    gp.incrementA(2),
                    gp.incrementplayerA(2)
                  }),
                  SizedBoxBtwBtns(),
                  Row(
                    children: [
                      kbButton(width: _btnWidth-50, title: "RAID:${gp.spinnervalueA}",
                          onTap: ()=>{gp.givespinnerValueA(_spinnerA),
                            gp.incrementA(_spinnerA),
                            gp.incrementplayerA(_spinnerA)
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
                    if(gp.playerinA <=3){
                      gp.incrementA(2),
                      gp.incrementplayerA(1)
                    }else{
                      gp.incrementA(1),
                      gp.incrementplayerA(1)
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
                    onPressed: () { },
                    child: Text('Team B',style: headline5WhiteBold,),
                  ),
                  Container(
                    child: giveHeadAsNo(no_of_players: gp.playerinB),
                  ),
                  SizedBoxBtwBtns(),
                  Text('${gp.scoreB}',style: headline1,),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "BONUS LINE", onTap: ()=>{gp.incrementB(1)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "EMPTY RAID", onTap: ()=>{gp.incrementB(0)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+1", onTap: ()=>{gp.incrementB(1),
                    gp.incrementplayerB(1)
                  }),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+2", onTap: ()=>{gp.incrementplayerB(2),
                  gp.incrementB(2)}),
                  SizedBoxBtwBtns(),
                  Row(
                    children: [
                      kbButton(width: _btnWidth-50, title: "RAID:${gp.spinnervalueB}",
                          onTap: ()=>{
                        gp.givespinnerValueB(_spinnerB),
                            gp.incrementB(gp.spinnervalueB),
                            gp.incrementplayerB(gp.spinnervalueB)
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
                    if(gp.playerinB<=3){
                      gp.incrementA(2),
                      gp.incrementplayerB(1)

                    }else{
                      gp.incrementplayerB(1),
                      gp.incrementB(1)

                    }

                  }),
                  SizedBoxBtwBtns(),
                ],
              ),
            ],
          ),
          CupertinoButton.filled(
            onPressed: () {},
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

  abc() {
    print("adfa");
  }
}
