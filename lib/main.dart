import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ATEditorApp());
}

class ATEditorApp extends StatelessWidget {
  const ATEditorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AT Editor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomeScreen(),
    );
  }
}
