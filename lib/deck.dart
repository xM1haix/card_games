// enum Deck { macau, the Seventh, popaProstu }
import 'package:card_games/playing_cards.dart';

List<PlayingCards> rentz(int players) => _trickTaking(players);

List<PlayingCards> theSeventh() {
  final List<PlayingCards> result = [];
  final values = [
    CardValue.seven,
    CardValue.eight,
    CardValue.nine,
    CardValue.ten,
    CardValue.J,
    CardValue.Q,
    CardValue.K,
  ];
  for (var v in values) {
    for (var c in CardColor.values) {
      result.add(PlayingCards(c, v));
    }
  }
  return result;
}

List<PlayingCards> whist(int players) => _trickTaking(players);

List<PlayingCards> _trickTaking(int players) {
  if (players < 3) throw "Not enough players";
  if (players > 6) throw "Too many players";
  final List<PlayingCards> result = [];
  final x = CardValue.values.reversed.toList();
  for (var i = 0; i < 2 * players; i++) {
    for (var c in CardColor.values) {
      result.add(PlayingCards(c, x[i]));
    }
  }
  return result;
}
