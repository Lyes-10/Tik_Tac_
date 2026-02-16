import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_withriverpod/Auth/pages/login.dart';
import 'package:to_do_withriverpod/Auth/pages/register.dart';
import 'package:to_do_withriverpod/Home/page/home.dart';
import 'package:to_do_withriverpod/bottonNav/bottonNav.dart';

void main() {
  runApp(ProviderScope
  (child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Login(),
    
    );
  }
}



