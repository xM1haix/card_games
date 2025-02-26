import 'dart:math';

import 'package:flutter/material.dart';

enum CardColor {
  blackSpade,
  redHeart,
  diamonds,
  club;

  Color get color => switch (this) {
    CardColor.blackSpade => Colors.black,
    CardColor.redHeart => Colors.red,
    CardColor.diamonds => Colors.black,
    CardColor.club => Colors.red,
  };
  String get simbol => switch (this) {
    CardColor.blackSpade => '♠',
    CardColor.redHeart => '♥',
    CardColor.diamonds => '♦',
    CardColor.club => '♣',
  };
}

enum CardValue {
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  J,
  Q,
  K,
  A;

  int get i => CardValue.values.indexOf(this);
  String get text => switch (this) {
    CardValue.two => '2',
    CardValue.three => '3',
    CardValue.four => '4',
    CardValue.five => '5',
    CardValue.six => '6',
    CardValue.seven => '7',
    CardValue.eight => '8',
    CardValue.nine => '9',
    CardValue.ten => '10',
    CardValue.J => 'J',
    CardValue.Q => 'Q',
    CardValue.K => 'K',
    CardValue.A => 'A',
  };
}

class CardWidget extends StatelessWidget {
  final int leftMargin;
  final PlayingCards card;
  const CardWidget(this.card, {super.key, this.leftMargin = 0});

  @override
  Widget build(BuildContext context) {
    final size = 100.0;
    return Container(
      margin: EdgeInsets.only(left: leftMargin * size / 2),
      alignment: Alignment.center,
      height: size * 1.54,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(size / 20),
      ),
      child: Text(
        card.toString(),
        style: TextStyle(color: card.textColor, fontSize: size / 2),
      ),
    );
  }
}

class DeckCard {
  List<PlayingCards> cards = [];
}

class PlayingCards {
  static List<PlayingCards> ordered = _genOrdered();
  static List<PlayingCards> get shuffle => _shuffle();

  final CardColor color;
  final CardValue value;
  PlayingCards(this.color, this.value);
  @override
  int get hashCode => color.hashCode ^ value.hashCode;
  Color get textColor => color.color;

  @override
  bool operator ==(Object other) {
    if (other is! PlayingCards) return false;
    return color == other.color && value == other.value;
  }

  @override
  String toString() => value.text + color.simbol;

  static PlayingCards randomCard() {
    final cards = _genOrdered();
    return cards[Random().nextInt(cards.length)];
  }

  static List<PlayingCards> _genOrdered() {
    final List<PlayingCards> result = [];
    for (var v in CardValue.values) {
      for (var c in CardColor.values) {
        result.add(PlayingCards(c, v));
      }
    }
    return result;
  }

  static List<PlayingCards> _shuffle() {
    final x = _genOrdered();
    final List<PlayingCards> result = [];
    while (x.isNotEmpty) {
      final id = Random().nextInt(x.length);
      result.add(x[id]);
      x.removeAt(id);
    }
    return result;
  }
}
