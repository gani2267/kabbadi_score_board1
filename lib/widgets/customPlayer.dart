import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class giveHeadAsNo extends StatelessWidget {
  giveHeadAsNo({Key? key,required this.no_of_players}) : super(key: key);

  int no_of_players;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (no_of_players>=1)?
        aa():Container(),
        (no_of_players>=2)?
        aa():Container(),
        (no_of_players>=3)?
        aa():Container(),
        (no_of_players>=4)?
        aa():Container(),
        (no_of_players>=5)?
        aa():Container(),
        (no_of_players>=6)?
        aa():Container(),
        (no_of_players==7)?
        aa():Container()
      ],
    );
  }

  Container aa(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: 8,
      child: Icon(Icons.person),
    );
  }
}
