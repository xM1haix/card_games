import "dart:math";

import "package:flutter/material.dart";
import "package:playing_cards/playing_cards.dart";

class Deck {
  Deck(GameData gameData, this.numOfPlayers) {
    _cards = gameData.deck(numOfPlayers);
  }
  int numOfPlayers;
  List<PlayingCard> _cards = [];
  List<PlayingCard> get cards => _cards;
  List<List<PlayingCard>> deal() {
    debugPrint((cards.length / numOfPlayers).toString());
    debugPrint((cards.length ~/ numOfPlayers).toString());
    if (cards.length / numOfPlayers != (cards.length ~/ numOfPlayers)) {
      throw Exception("""
  Something is wrong as number of cards do not match the number of players
        """);
    }
    final hands = List<List<PlayingCard>>.generate(numOfPlayers, (_) => []);
    for (var i = 0; i < _cards.length; i++) {
      hands[i % numOfPlayers].add(_cards[i]);
    }
    return hands;
  }

  void shuffle() {
    final newCards = <PlayingCard>[];
    while (_cards.isNotEmpty) {
      final id = Random().nextInt(_cards.length);
      newCards.add(_cards[id]);
      _cards.removeAt(id);
    }
    _cards = newCards;
  }
}

class GameData {
  GameData(this.gameType) {
    switch (gameType) {
      case GameType.wars:
        _minPlayers = 2;
        _maxPlayers = 26;
        _deck = (i) => standardFiftyTwoCardDeck();

      case GameType.macau:
        _minPlayers = 2;
        _maxPlayers = 10;
        _deck = (i) => standardFiftyFourCardDeck();
      case GameType.rentz:
        _minPlayers = 3;
        _maxPlayers = 6;
        _deck = _trickTaking;
      case GameType.theSeventh:
        _minPlayers = 2;
        _maxPlayers = 8;
        _deck = (i) => _trickTaking(4);
      case GameType.whist:
        _minPlayers = 3;
        _maxPlayers = 6;
        _deck = _trickTaking;
      case GameType.trickTaking:
        _minPlayers = 3;
        _maxPlayers = 6;
        _deck = _trickTaking;
    }
  }
  late List<PlayingCard> Function(int numberOfPlayers) _deck;
  late int _minPlayers;
  late int _maxPlayers;
  final GameType gameType;
  List<PlayingCard> Function(int numberOfPlayers) get deck => _deck;
  void checkPlayerNumber(int currentPlayers) {
    if (currentPlayers <= _minPlayers) {
      throw Exception("Not enough players, required minimum of $_minPlayers");
    }
    if (currentPlayers >= _maxPlayers) {
      throw Exception("Too many players, max allowed players is $_maxPlayers");
    }
  }

  static List<PlayingCard> _trickTaking(int players) {
    final result = <PlayingCard>[];
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
      for (final c in STANDARD_SUITS) {
        result.add(PlayingCard(c, x[i]));
      }
    }
    return result;
  }
}

enum GameType { wars, macau, rentz, theSeventh, whist, trickTaking }
