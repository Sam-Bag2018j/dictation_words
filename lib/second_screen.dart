// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:ffi';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dictation_words/constants.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  List<String> listWords = [];
  int selectedNum = 0;
  // ignore: use_key_in_widget_constructors
  SecondScreen({required this.listWords, required this.selectedNum});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  var tempWords = <String>{};

  bool status = true;
  int counter = 0;
  Widget _fade() {
    widget.listWords.shuffle();
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 22;
    double multiplier2 = 15;
    print(tempWords);
    return SizedBox(
      child: DefaultTextStyle(
        style: TextStyle(
            fontSize: widget.listWords[0].length >= 5
                ? multiplier2 * unitHeightValue
                : multiplier * unitHeightValue,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'ComicSansMS3'),
        child: Center(
          child: AnimatedTextKit(
            repeatForever: true,
            onTap: () {},
            pause: Duration(seconds: 1),
            animatedTexts: [
              for (int x = 0; x < widget.selectedNum; x++)
                FadeAnimatedText(widget.listWords[x],
                    duration: Duration(seconds: 2),
                    fadeOutBegin: 0.9,
                    fadeInEnd: 0.8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: prime_color,
              leading: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: IconButton(
                  // ignore: prefer_const_constructors
                  icon: Icon(
                    Icons.keyboard_return_sharp,
                    size: 50,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )),
          body: SafeArea(
              //  mainAxisAlignment: MainAxisAlignment.center,
              //children: [
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                _fade(),
                SizedBox(
                  height: 50,
                )
              ])),

          floatingActionButton: Container(
            //  padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            height: 70,
            width: 70,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: onPrime_color, // Colors.orange,
                heroTag: 'hero1',
                // hoverColor: Colors.green,
                tooltip: 'Reset',
                onPressed: () {
                  setState(() {
                    //  widget.listWords.shuffle();
                    // counter = 0;
                    _fade();
                  });
                },
                child: Text(
                  'Reset',
                  style: butn_style,
                ),
              ),
            ),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }
}
