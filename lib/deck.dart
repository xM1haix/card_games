import "dart:math";

import "package:playing_cards/playing_cards.dart";

///Object which represent the card Deck
class Deck {
  ///Required the [GameData] and the [numOfPlayers]
  Deck(GameData gameData, this.numOfPlayers) {
    _cards = gameData.deck(numOfPlayers);
  }

  ///The number of players for the game
  int numOfPlayers;
  List<PlayingCard> _cards = [];

  ///the cards
  List<PlayingCard> get cards => _cards;

  ///Function which split the cards to the players even
  List<List<PlayingCard>> deal() {
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

  /// Shuffle the deck
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

///Object which represent the Game informations
class GameData {
  ///Requires the [gameType]
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

  ///The game type [GameType]
  final GameType gameType;

  ///The cards [deck]
  List<PlayingCard> Function(int numberOfPlayers) get deck => _deck;

  ///Function which will check the number of players
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

/// enum of game type
enum GameType {
  ///https://en.wikipedia.org/wiki/War_(card_game)
  wars,

  ///https://en.wikipedia.org/wiki/Macau_(card_game)
  macau,

  ///https://ro.wikipedia.org/wiki/Rentz
  rentz,

  ///https://www.goobix.com/games/seventh/
  theSeventh,

  ///https://en.wikipedia.org/wiki/Whist
  whist,

  ///https://en.wikipedia.org/wiki/Trick-taking_game
  trickTaking,
}
