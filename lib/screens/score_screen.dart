import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabbadi_score_board/providers/scoreA_provider.dart';
import 'package:kabbadi_score_board/providers/timer_provider.dart';
import 'package:kabbadi_score_board/widgets/customPlayer.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:riverpod/riverpod.dart';

import '../components/compo.dart';
import '../providers/scoreB_provider.dart';
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

    int _spinnerA = context.read<SpinnerA>().value;
    int _spinnerB = context.read<SpinnerB>().value;
    bool _isTimerPause = false;

    int _playerTeamB = context.read<teamB>().playerNo;
    int _playerTeamA = context.read<teamA>().playerNo;
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<TimeStrings>(
            builder: (BuildContext context, value, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kbButton(width: 100, title:
                        value.startbtn, onTap: () =>
                        {
                          _isTimerPause = !_isTimerPause,
                          value.changeValue(_isTimerPause),
                          value.timer(!_isTimerPause),
                          _streamDuration.pause(),
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
              );
            }
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
                    child: giveHeadAsNo(no_of_players: _playerTeamA),
                  ),
                  SizedBoxBtwBtns(),
                  Text('${context.watch<ScoreACounter>().scoreA}',style: headline1,),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "BONUS LINE", onTap: ()=>{context.read<ScoreACounter>().increment(1)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "EMPTY RAID", onTap: ()=>{context.read<ScoreACounter>().increment(0)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+1", onTap: ()=>{
                    context.read<ScoreACounter>().increment(1),
                    context.watch<teamB>().decrement(1)
                    }
                  ),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+2", onTap: ()=>{context.read<ScoreACounter>().increment(2)}),
                  SizedBoxBtwBtns(),
                  Row(
                    children: [
                      kbButton(width: _btnWidth-50, title: "RAID:${context.watch<SpinnerA>().value}",
                          onTap: ()=>{context.read<ScoreACounter>().increment(_spinnerA)}),
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
                            context.read<SpinnerA>().giveValue(value!);
                          }),
                    ],
                  ),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "DEFEND", btnColor: morpic, onTap: ()=>{context.read<ScoreACounter>().increment(1)}),
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
                    child: giveHeadAsNo(no_of_players: _playerTeamB),
                  ),
                  SizedBoxBtwBtns(),
                  Text('${context.watch<ScoreBCounter>().scoreB}',style: headline1,),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "BONUS LINE", onTap: ()=>{context.read<ScoreBCounter>().increment(1)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "EMPTY RAID", onTap: ()=>{context.read<ScoreBCounter>().increment(0)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+1", onTap: ()=>{context.read<ScoreBCounter>().increment(1)}),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "RAID:+2", onTap: ()=>{context.read<ScoreBCounter>().increment(2)}),
                  SizedBoxBtwBtns(),
                  Row(
                    children: [
                      kbButton(width: _btnWidth-50, title: "RAID:${context.watch<SpinnerB>().value}",
                          onTap: ()=>{context.read<ScoreBCounter>().increment(_spinnerB)}),
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
                            context.read<SpinnerB>().giveValue(value!);
                          }),
                    ],
                  ),
                  SizedBoxBtwBtns(),
                  kbButton(width: _btnWidth, title: "DEFEND", btnColor: morpic, onTap: ()=>{context.read<ScoreBCounter>().increment(1)}),
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

  abc() {
    print("adfa");
  }
}
