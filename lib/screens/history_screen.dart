import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabbadi_score_board/utils/history_element.dart';
import 'package:provider/provider.dart';

import '../providers/global_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = context.read<global_provider>().historylist;
    return Scaffold(
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            HistoryElement item = list[index];
            return HistoryItem(teamName: item.teamName, msg: item.msg, teamAscore: item.teamAscore, teamBscore: item.teamBscore);
          },
      )
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({Key? key, required this.teamName, required this.msg, required this.teamAscore, required this.teamBscore}) : super(key: key);

  final String teamName;
  final String msg;
  final int teamAscore;
  final int teamBscore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(teamName+" : "),
            Text(msg),
          ],
        ),
        Text("${teamAscore}:${teamBscore}")
      ],
    );
  }
}

