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
          backgroundColor: Color.fromARGB(255, 52, 52, 52),
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
    final cardData = provider.cardData;

    if (cardData.isEmpty) {
      return Center(
      child: ElevatedButton(
        onPressed: () {
          provider.resetCards();
        },
        child: const Text("Reset"),
      ),
    );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0),
      child: Stack(
        children: cardData.map((cardInfo) => 
          TinderCard(
            cardInfo: cardInfo,
            isFront: cardData.last['id'] == cardInfo['id'],
          )
        ).toList(),
      )
    );
  }
}