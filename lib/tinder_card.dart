import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_micard_flutter/business_card.dart';
import 'package:test_micard_flutter/util/card_provider.dart';

class TinderCard extends StatefulWidget {
  final dynamic cardInfo;
  final bool isFront;
  const TinderCard({super.key, required this.cardInfo, required this.isFront});

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFront ? buildFrontCard() : buildCard();
  }

  // add gesture detector to Card
  Widget buildFrontCard() => GestureDetector(
    child: Builder(
      builder: (context) {
        final provider = Provider.of<CardProvider>(context);
        final position = provider.position;
        final milliseconds = provider.isDragging ? 0 : 400;

        final double x = position.dx;
        final double y = position.dy;

        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: milliseconds),
          transform: Matrix4.identity()..translate(x, y),
          child: buildCard()
        );
      }
    ),
    onPanStart: (details) {
      final provider = Provider.of<CardProvider>(context, listen: false);

      provider.startPosition(details);
    },
    onPanUpdate: (details) {
      final provider = Provider.of<CardProvider>(context, listen: false);

      provider.updatePosition(details);
    },
    onPanEnd: (details) {
      final provider = Provider.of<CardProvider>(context, listen: false);
      
      provider.endPosition();
    },
  );

  

  // main card widget builder
  Widget buildCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BusinessCard(
        imgUrl: widget.cardInfo['cardUrl'], 
        name: widget.cardInfo['name'], 
        title: widget.cardInfo['title'], 
        phoneNo: widget.cardInfo['number'], 
        location: widget.cardInfo['location'], 
        avatarUrl: widget.cardInfo['avatarUrl'],
      ),
    );
  }
}
