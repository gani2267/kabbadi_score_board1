import 'package:flutter/material.dart';
import 'package:kabbadi_score_board/providers/scoreA_provider.dart';
import 'package:kabbadi_score_board/providers/scoreB_provider.dart';
import 'package:kabbadi_score_board/providers/timer_provider.dart';
import 'package:kabbadi_score_board/screens/home_screen.dart';
import 'package:kabbadi_score_board/styles.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ScoreACounter()),
      ChangeNotifierProvider(create: (_) => SpinnerA()),
      ChangeNotifierProvider(create: (_) => ScoreBCounter()),
      ChangeNotifierProvider(create: (_) => teamB()),
      ChangeNotifierProvider(create: (_) => teamA()),
      ChangeNotifierProvider(create: (_) => SpinnerB()),
      ChangeNotifierProvider(create: (_) => TimeStrings()),
    ],
    child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        widget = botToastBuilder(context, widget);
        widget = MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget);
        widget = ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget),
            maxWidth: 1200,
            minWidth: 360,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(360, name: MOBILE),
              ResponsiveBreakpoint.resize(420, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: Color(0xFFF5F5F5)));
        return widget;
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'ibmPlexSans',
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        dividerColor: grey,
        splashColor: grey,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: almostWhite)),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusColor: almostWhite,
            labelStyle: bodyText2White60),
      ),
      home: const HomeScreen(),
    );
  }
}
