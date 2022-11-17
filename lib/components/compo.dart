import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabbadi_score_board/styles.dart';

class kbButton extends StatelessWidget {
  kbButton({Key? key, required this.width, required this.title, required this.onTap, this.btnColor}) : super(key: key);

  final double width;
  final String title;
  final VoidCallback onTap;
  Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      child: CupertinoButton(
        color: btnColor ?? Colors.pink,
        padding: EdgeInsets.symmetric(horizontal: 13,vertical: 0),
        onPressed: onTap,
        child: Text(
          title,
        ),
      ),
    );
  }
}


