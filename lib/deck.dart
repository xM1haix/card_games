import 'dart:math';

import 'package:playing_cards/playing_cards.dart';

class Deck {
  int numOfPlayers;
  List<PlayingCard> _cards = [];
  Deck(GameData gameData, this.numOfPlayers) {
    _cards = gameData.deck(numOfPlayers);
  }
  List<PlayingCard> get cards => _cards;
  List<List<PlayingCard>> deal() {
    print(cards.length / numOfPlayers);
    print(cards.length ~/ numOfPlayers);
    if (cards.length / numOfPlayers != (cards.length ~/ numOfPlayers)) {
      throw "Something is wrong as number of cards do not match the number of players";
    }
    final List<List<PlayingCard>> hands = List.generate(
      numOfPlayers,
      (_) => [],
    );
    for (int i = 0; i < _cards.length; i++) {
      hands[i % numOfPlayers].add(_cards[i]);
    }
    return hands;
  }

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
  late List<PlayingCard> Function(int numberOfPlayers) _deck;
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
  List<PlayingCard> Function(int numberOfPlayers) get deck => _deck;
  void checkPlayerNumber(int currentPlayers) {
    if (currentPlayers <= _minPlayers) {
      throw "Not enough players, required minimum of $_minPlayers";
    }
    if (currentPlayers >= _maxPlayers) {
      throw "Too many players, max allowed players is $_maxPlayers";
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

enum GameType { wars, macau, rentz, theSeventh, whist, trickTaking }
