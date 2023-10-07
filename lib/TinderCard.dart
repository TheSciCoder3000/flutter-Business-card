import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_micard_flutter/card_provider.dart';

class TinderCard extends StatefulWidget {
  final String imgUrl;
  const TinderCard({super.key, required this.imgUrl});

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
    return buildFrontCard();
  }

  Widget buildFrontCard() => GestureDetector(
    child: Builder(
      builder: (context) {
        final provider = Provider.of<CardProvider>(context);
        final position = provider.position;
        final milliseconds = provider.isDragging ? 0 : 400;

        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: milliseconds),
          transform: Matrix4.identity()..translate(position.dx, 0),
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

  Widget buildCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.imgUrl), 
              fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}
