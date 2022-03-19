// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:dictation_words/constants.dart';
import 'package:dictation_words/second_screen.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* List<BasicJson> parseBasicJsons(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<BasicJson>((json) => BasicJson.fromJson(json)).toList();
  }*/

  // ignore: non_constant_identifier_names
  List wordsSample = [];
  int selectedNmberOfLetters = 3;
  int selectedNumberOfWords = 5;
  void LoadJsonAsync() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/words.json");
    //print(data);
    List<dynamic> allOfwordsList = jsonDecode(data); //wordsSample
    // var user = User.fromJso n(userMap[1]);
    wordsSample = allOfwordsList
        .map<WordsModel>((json) => WordsModel.fromJson(json))
        .toList();

    // print('Howdy, ${wordsSample[0].name}! Your age is ${[0].length}');
    //print('${wordsSample[0].words_sample}.');
    // print('${wordsSample[0]}' + 'this is words sample');
    // print('$wordsList' + 'this is words list');
    // print(wordsSample[0].length);
  }

  @override
  void initState() {
    super.initState();
    LoadJsonAsync();
  }

  List<String> listOfWords(x) {
    List<String> wantedLength = [];
    for (int i = 0; i < wordsSample.length; i++) {
      if (wordsSample[i].length == x) {
        wantedLength = wordsSample[i].words_sample;
      }
    }
    print(wantedLength);

    return wantedLength;
  }

  /*Widget buildPicker() {
    return SizedBox(
      height: 250,
      child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged: (int value) {
            setState(() {
              selectedNmberOfLetters = value + 3;
              // convertToInt(numberOfLetters[value].toString());

              print(selectedNmberOfLetters);
            });
          },
          children:
              // ignore: avoid_types_as_parameter_names
              numberOfLetters),
    );
  }*/

  /* Widget buildPickerForWords() {
    return SizedBox(
      height: 250,
      child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged: (int value) {
            setState(() {
               selectedNumberOfWords = numberOfWords[value];
              // convertToInt(numberOfLetters[value].toString());

              print(selectedNumberOfWords);
            });
          },
          children:
              // ignore: avoid_types_as_parameter_names
              numberOfLetters),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: prime_color,
        title: Text(
          "Dictation App",
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Select Number Of Letters:', style: tex_sty),
                      NumberPicker(
                          minValue: 3,
                          maxValue: 7,
                          value: selectedNmberOfLetters,
                          onChanged: (value) => setState(() {
                                selectedNmberOfLetters = value;
                              }))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Select Number Of Words:', style: tex_sty),
                      NumberPicker(
                          minValue: 5,
                          maxValue: 50,
                          step: 5,
                          value: selectedNumberOfWords,
                          onChanged: (value) => setState(() {
                                selectedNumberOfWords = value;
                              })),
                    ]),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(20),
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: onPrime_color,
            child: Text(
              'Start',
              style: butn_style,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(
                    listWords: listOfWords(selectedNmberOfLetters),
                    selectedNum: selectedNumberOfWords,
                  ),
                )),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}

/*class BasicJson {
  final int id;
  final String title;

  const BasicJson({
    required this.id,
    required this.title,
  });

  BasicJson.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}*/

class WordsModel {
  final String name;
  final int length;
  // ignore: non_constant_identifier_names
  final List<String> words_sample;

  WordsModel(this.name, this.length, this.words_sample);

  WordsModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        length = json['length'],
        words_sample = List<String>.from(json["words_sample"].map((x) => x));

  Map<String, dynamic> toJson() => {
        'name': name,
        'length': length,
        'words_sample': words_sample,
      };
}
