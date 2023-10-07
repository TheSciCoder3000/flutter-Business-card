import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_micard_flutter/TinderCard.dart';
import 'package:test_micard_flutter/card_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.teal,
          body: SafeArea(child: MainPage()),
        ),
      ),
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0),
      child: const TinderCard(
          imgUrl:
              'https://cdn.vox-cdn.com/thumbor/fFu0lMnsc4-6UtX0FSK6uIiJe_w=/0x0:3000x1779/920x613/filters:focal(1204x216:1684x696):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/59606327/ktokatitmir0.0.jpg'),
    );
  }
}
