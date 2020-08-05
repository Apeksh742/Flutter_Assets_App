import 'package:flutter/material.dart';
import 'package:video_app/ui.dart';


void main() => runApp(AssetsApp());

class AssetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assets App',
      home: 
       VideoPlayerScreen(),
       debugShowCheckedModeBanner: false,
    );
  }
}
