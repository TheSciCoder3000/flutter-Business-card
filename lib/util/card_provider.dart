
import 'package:flutter/material.dart';

enum CardStatus { accept, reject, pending }

class CardProvider extends ChangeNotifier {
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  List<String> _urlImages = [];
  final _delta = 300;

  // 0 - none | 1 - horizontal | -1 - vertical
  int _initalDrag = 0;

  Offset get position => _position;
  bool get isDragging => _isDragging;
  int get initalDrag => _initalDrag;
  List<String> get getUrlImages => _urlImages;

  CardProvider() {
    resetCards();
  }

  void resetCards() {
    _urlImages = <String>[
      'https://cdn.vox-cdn.com/thumbor/fFu0lMnsc4-6UtX0FSK6uIiJe_w=/0x0:3000x1779/920x613/filters:focal(1204x216:1684x696):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/59606327/ktokatitmir0.0.jpg',
      'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/9/9a/BlackWidow-EndgameProfile.jpg/revision/latest?cb=20190423174842',
    ].reversed.toList();

    notifyListeners();
  }
  
  // ============================= DRAG EVENTS =============================  
  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    // update _initalDrag
    if (_initalDrag == 0) {
      if (details.delta.dx.abs() > details.delta.dy.abs()) {
        _initalDrag = 1;
      } else {
        _initalDrag = -1;
      }
    }
    _position += details.delta;
    notifyListeners();
  }

  void endPosition() {
    _initalDrag = 0;
    _isDragging = false;
    notifyListeners();

    final status = getStatus();

    switch(status) {
      case CardStatus.accept:
        acceptCard();
        break;
      case CardStatus.reject:
        rejectCard();
        break;
      case CardStatus.pending:
        pendingCard();
        break;
      default:
        resetPosition();
    }
  }

  
  // ============================= CARD STATUS EVENTS =============================  
  void acceptCard() {
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }
  
  void rejectCard() {
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void pendingCard() {
    _position -= Offset(0, _screenSize.height);
    _nextCard();

    notifyListeners();
  }


  // ============================= HELPER FUNCTIONS =============================  
  Future _nextCard() async {
    if (_urlImages.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _urlImages.removeLast();
    resetPosition();
  }
  
  CardStatus? getStatus() {
    final x = _position.dx;
    final y = _position.dy;
    final bool isDragUp = x.abs() < 20;

    if (x >= _delta) {
      return CardStatus.accept;
    } else if (x <= -_delta) {
      return CardStatus.reject;
    } else if (y <= -_delta/2 && isDragUp) {
      return CardStatus.pending;
    }
    return null;
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;

    notifyListeners();
  }
}
