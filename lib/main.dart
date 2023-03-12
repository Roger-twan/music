import 'package:flutter/material.dart';
import 'bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffD00A07),
        iconTheme: IconThemeData(color: Colors.grey[400])
      ),
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: Text('data'),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
