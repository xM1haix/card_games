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
  final int _players = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HOME")),
      body: Stack(
        children:
            standardFiftyFourCardDeck()
                .asMap()
                .entries
                .map(
                  (e) => Container(
                    height: 2 * 150,
                    margin: EdgeInsets.only(left: e.key * 2 * 15),
                    child: PlayingCardView(card: e.value),
                  ),
                )
                .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _init(Random().nextInt(4) + 3);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // _init();
  }

  // void _init([int? players]) {
  //   setState(() {
  //     if (players != null) _players = players;
  //     _deck = Deck.rentz(_players);
  //   });
  // }
}
