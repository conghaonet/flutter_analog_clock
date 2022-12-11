import 'package:flutter/material.dart';

import 'analog_clock_example.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        /// 使用 Material3 样式
        useMaterial3: true,
      ),
      home: const FlutterAnalogClockDemo(),

    );
  }
}