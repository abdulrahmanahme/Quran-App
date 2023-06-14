import 'package:flutter/material.dart';
import 'package:quran_app/core/constant_app/constant.dart';
import 'package:quran_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
      await getSettings();
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        sliderTheme: SliderTheme.of(context).copyWith(
          trackHeight: 4.0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
