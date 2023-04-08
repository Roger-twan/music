import 'package:flutter/material.dart';
import 'provider/preferences.dart';
import 'widget/bottom_bar/index.dart';
import 'widget/search/index.dart';
import 'widget/left_drawer/index.dart';
import 'widget/upload/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Preferences().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffD00A07),
        iconTheme: IconThemeData(color: Colors.grey[400]),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.grey[400]
          ),
        )
      ),
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: SearchScreen(),
        bottomNavigationBar: BottomBar(),
        drawer: LeftDrawer(),
        endDrawer: UploadDrawer(),
      ),
    );
  }
}
