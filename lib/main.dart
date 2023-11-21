import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/link.dart';

void main() {
  runApp(const MainApp());
}

Color getRandomColor() {
  var random = Random();
  var r = random.nextInt(256);
  var g = random.nextInt(256);
  var b = random.nextInt(256);
  return Color.fromRGBO(r, g, b, 1);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: getRandomColor(),
        ),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          elevation: 4,
          child: Container(
            width: 360,
            height: 520,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/profile.png',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const FittedBox(
                  child: Text(
                    'Kyohei Nakamura',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const FittedBox(
                  child: Text('Sheep and Goat, LLC'),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Link(
                    uri: Uri.parse('https://sheepandgoat.io'),
                    target: LinkTarget.blank,
                    builder: (context, followLink) => IconButton(
                      onPressed: followLink,
                      icon: SvgPicture.asset(
                        'assets/images/sag-logo-black.svg',
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
