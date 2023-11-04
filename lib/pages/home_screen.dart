import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Color randomColor = Color.fromARGB(255, 255, 255, 50);
  Color? newRandomColor;

  @override
  void initState() {
    super.initState();
    loadColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ramdom Color Generator"),
        elevation: 5.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          listGenerator();
        },
        child: const Icon(Icons.add_circle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                color: newRandomColor,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void listGenerator() {
    Random numbs = Random();
    List? randomList;
    setState(() {
      for (int i = 0; i < 5; i++) {
        randomList = [
          numbs.nextInt(255),
          numbs.nextInt(255),
          numbs.nextInt(255),
          numbs.nextInt(255)
        ];
      }

      randomColor = Color.fromARGB(
          randomList!.elementAt(0),
          randomList!.elementAt(1),
          randomList!.elementAt(2),
          randomList!.elementAt(3));
      setColor(randomList);
    });
  }

  Future<void> setColor(randomList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("color1", randomList.elementAt(0));
    await prefs.setInt("color2", randomList.elementAt(1));
    await prefs.setInt("color3", randomList.elementAt(2));
    await prefs.setInt("color4", randomList.elementAt(3));
    loadColor();
  }

  Future<Color> loadColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      newRandomColor = Color.fromARGB(
          prefs.getInt("color1")!,
          prefs.getInt("color2")!,
          prefs.getInt("color3")!,
          prefs.getInt("color4")!);
    });

    return newRandomColor!;
  }
}
