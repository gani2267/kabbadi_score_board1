import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabbadi_score_board/screens/score_screen.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../styles.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Custom Match"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelStyle: subtitle2White,
              unselectedLabelColor: Colors.white38,
              //indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(
                horizontalPadding: 24,
                bottomLeftRadius: 8,
                bottomRightRadius: 8,
                color: almostWhite,
                paintingStyle: PaintingStyle.fill,
              ),
              tabs: [
                Tab(
                  text: "Score",
                ),
                Tab(
                  text: "History",
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ScoreScreen(),
                    HistoryScreen(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
