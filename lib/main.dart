import 'dart:math';

import 'package:card_games/deck.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Deck _deck;
  final _cardSize = 200.0;
  List<List<PlayingCard>> _dealtCards = [];
  var _players = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(
            onPressed: () => setState(() => _deck.shuffle()),
            icon: Icon(Icons.shuffle),
          ),
          IconButton(
            onPressed: () => setState(() => _dealtCards = _deck.deal()),
            icon: Icon(Icons.splitscreen),
          ),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children:
                _deck.cards
                    .asMap()
                    .entries
                    .map(
                      (e) => Container(
                        height: _cardSize,
                        margin: EdgeInsets.only(left: e.key * _cardSize / 10),
                        child: PlayingCardView(card: e.value),
                      ),
                    )
                    .toList(),
          ),
          Wrap(
            runSpacing: 10,
            spacing: 200,
            children:
                _dealtCards
                    .map(
                      (p) => Stack(
                        children:
                            p
                                .asMap()
                                .entries
                                .map(
                                  (c) => Container(
                                    height: _cardSize,
                                    margin: EdgeInsets.only(
                                      left: c.key * _cardSize / 10,
                                    ),
                                    child: PlayingCardView(card: c.value),
                                  ),
                                )
                                .toList(),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _init(Random().nextInt(4) + 3);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init([int? players]) {
    setState(() {
      if (players != null) _players = players;
      _deck = Deck(GameData(GameType.rentz), _players);
    });
  }
}
