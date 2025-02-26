import 'dart:math';

import 'package:playing_cards/playing_cards.dart';

class Deck {
  final GameType gameType;
  List<PlayingCard> _cards = [];
  final int numOfPlayers;
  Deck(this.gameType, this.numOfPlayers) {
    switch (gameType) {
      case GameType.macau:
        if (numOfPlayers < 2) throw "Not enough players";
        if (numOfPlayers > 10) throw "too many players";
        _cards = standardFiftyFourCardDeck();
        break;
      case GameType.wars:
        if (numOfPlayers < 2) throw "Not enough players";
        if (numOfPlayers > 26) throw "too many players";
        _cards = standardFiftyTwoCardDeck();
        break;
      default:
    }
    if (numOfPlayers < 2) throw "Not enough players";
    if (numOfPlayers > 26) throw "too many players";
    for (var v in SUITED_VALUES) {
      for (var c in STANDARD_SUITS) {
        _cards.add(PlayingCard(c, v));
      }
    }
  }
  // factory Deck.macau(int numOfPlayers) {
  //   if (numOfPlayers < 2) throw "Not enough players";
  //   if (numOfPlayers > 10) throw "too many players";
  //   return Deck(standardFiftyFourCardDeck(), numOfPlayers);
  // }

  // factory Deck.rentz(int players) => _trickTaking(players);
  // factory Deck.theSeventh() => _trickTaking(4);
  // factory Deck.whist(int players) => _trickTaking(players);
  List<PlayingCard> get cards => _cards;
  void shuffle() {
    final List<PlayingCard> newCards = [];
    while (_cards.isNotEmpty) {
      final id = Random().nextInt(_cards.length);
      newCards.add(_cards[id]);
      _cards.removeAt(id);
    }
    _cards = newCards;
  }
}

class GameData {
  late List<PlayingCard> Function(int x) _deck;
  late int _minPlayers, _maxPlayers;
  final GameType gameType;
  GameData(this.gameType) {
    switch (gameType) {
      case GameType.wars:
        _minPlayers = 2;
        _maxPlayers = 26;
        _deck = (i) => standardFiftyTwoCardDeck();

        break;
      case GameType.macau:
        _minPlayers = 2;
        _maxPlayers = 10;
        _deck = (i) => standardFiftyFourCardDeck();
        break;
      case GameType.rentz:
        _minPlayers = 3;
        _maxPlayers = 6;
        _deck = _trickTaking;
        break;
      case GameType.theSeventh:
        _minPlayers = 2;
        _maxPlayers = 8;
        _deck = (i) => _trickTaking(4);
        break;
      case GameType.whist:
        _minPlayers = 3;
        _maxPlayers = 6;
        _deck = _trickTaking;
        break;
      case GameType.trickTaking:
        _minPlayers = 3;
        _maxPlayers = 6;
        _deck = _trickTaking;
        break;
    }
  }
  static List<PlayingCard> _trickTaking(int players) {
    final List<PlayingCard> result = [];
    final x = [
      CardValue.ace,
      CardValue.king,
      CardValue.queen,
      CardValue.jack,
      CardValue.ten,
      CardValue.nine,
      CardValue.eight,
      CardValue.seven,
      CardValue.six,
      CardValue.five,
      CardValue.four,
      CardValue.three,
    ];
    for (var i = 0; i < 2 * players; i++) {
      for (var c in STANDARD_SUITS) {
        result.add(PlayingCard(c, x[i]));
      }
    }
    return result;
  }
}

class GamePlayers {
  final int minPlayers, maxPlayers;
  GamePlayers(this.minPlayers, this.maxPlayers);
  void checkNumOfPlayers(int currentPlayers) {
    if (currentPlayers <= minPlayers) {
      throw "Not enough players, required minimum of $minPlayers";
    }
    if (currentPlayers >= maxPlayers) {
      throw "Too many players, max allowed players is $maxPlayers";
    }
  }
}

enum GameType {
  wars,
  macau,
  rentz,
  theSeventh,
  whist,
  trickTaking;

  void gameMode(int numOfPlayers) => (switch (this) {
    GameType.wars => GamePlayers(2, 26),
    GameType.macau => GamePlayers(2, 10),
    GameType.rentz => GamePlayers(3, 6),
    GameType.theSeventh => GamePlayers(2, 8),
    GameType.whist => GamePlayers(3, 6),
    GameType.trickTaking => GamePlayers(3, 6),
  }).checkNumOfPlayers(numOfPlayers);
}
