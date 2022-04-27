import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tbr_group_test/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      title: 'tbr_group',
      home: HomePage(),
    );
  }
}
