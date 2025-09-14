import "dart:math";

import "package:flutter/material.dart";

/// Card color
enum CardColor {
  ///https://en.wikipedia.org/wiki/Spades_(suit)
  blackSpade,

  ///https://en.wikipedia.org/wiki/Hearts_(suit)
  redHeart,

  ///https://en.wikipedia.org/wiki/Diamonds_(suit)
  diamonds,

  ///https://en.wikipedia.org/wiki/Clubs_(suit)
  club;

  ///Generate the [Color] based on the [CardColor]
  Color get color => switch (this) {
    CardColor.blackSpade => Colors.black,
    CardColor.redHeart => Colors.red,
    CardColor.diamonds => Colors.black,
    CardColor.club => Colors.red,
  };

  ///Generate the [String] based on the [CardColor]
  String get simbol => switch (this) {
    CardColor.blackSpade => "♠",
    CardColor.redHeart => "♥",
    CardColor.diamonds => "♦",
    CardColor.club => "♣",
  };
}

///The value of the card
enum CardValue {
  /// 2
  two,

  /// 3
  three,

  /// 4
  four,

  /// 5
  five,

  /// 6
  six,

  /// 7
  seven,

  /// 8
  eight,

  /// 9
  nine,

  /// 10
  ten,

  /// J
  J,

  /// Q
  Q,

  /// K
  K,

  /// A
  A;

  ///

  int get i => CardValue.values.indexOf(this);

  ///Generate the [String] based on the [CardValue]
  String get text => switch (this) {
    CardValue.two => "2",
    CardValue.three => "3",
    CardValue.four => "4",
    CardValue.five => "5",
    CardValue.six => "6",
    CardValue.seven => "7",
    CardValue.eight => "8",
    CardValue.nine => "9",
    CardValue.ten => "10",
    CardValue.J => "J",
    CardValue.Q => "Q",
    CardValue.K => "K",
    CardValue.A => "A",
  };
}

///Widget showing the [GameCard]
class CardWidget extends StatelessWidget {
  ///It require the [card] as [GameCard] and the [leftMarin] as int default is 0
  const CardWidget(this.card, {super.key, this.leftMargin = 0});

  ///The margin at left
  final int leftMargin;

  ///The card it self
  final GameCard card;

  @override
  Widget build(BuildContext context) {
    const size = 100.0;
    return Container(
      margin: EdgeInsets.only(left: leftMargin * size / 2),
      alignment: Alignment.center,
      height: size * 1.54,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(size / 20),
      ),
      child: Text(
        card.toString(),
        style: TextStyle(color: card.textColor, fontSize: size / 2),
      ),
    );
  }
}

@immutable
///Object which represent the final GameCard
class GameCard {
  ///Create the [GameCard] based on the [color] and the [value]
  const GameCard(this.color, this.value);

  ///
  static List<GameCard> ordered = _genOrdered();

  ///Shuffle the [GameCard]
  static List<GameCard> get shuffle => _shuffle();

  ///The [color] of the [GameCard]
  final CardColor color;

  ///The [value] of the [GameCard]
  final CardValue value;
  @override
  int get hashCode => color.hashCode ^ value.hashCode;

  ///Getting the [textColor] based on the color of the [GameCard]
  Color get textColor => color.color;

  @override
  bool operator ==(Object other) {
    if (other is! GameCard) {
      return false;
    }
    return color == other.color && value == other.value;
  }

  @override
  String toString() => value.text + color.simbol;

  ///
  static GameCard randomCard() {
    final cards = _genOrdered();
    return cards[Random().nextInt(cards.length)];
  }

  static List<GameCard> _genOrdered() {
    final result = <GameCard>[];
    for (final v in CardValue.values) {
      for (final c in CardColor.values) {
        result.add(GameCard(c, v));
      }
    }
    return result;
  }

  static List<GameCard> _shuffle() {
    final x = _genOrdered();
    final result = <GameCard>[];
    while (x.isNotEmpty) {
      final id = Random().nextInt(x.length);
      result.add(x[id]);
      x.removeAt(id);
    }
    return result;
  }
}
