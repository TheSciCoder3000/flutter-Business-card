import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_micard_flutter/tinder_card.dart';
import 'package:test_micard_flutter/util/card_provider.dart';

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
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.getUrlImages;
    print(urlImages);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0),
      child: Stack(
        children: urlImages.map((urlImage) => 
          TinderCard(
            imgUrl: urlImage,
            isFront: urlImages.last == urlImage,
          )
        ).toList(),
      )
    );
  }
}
