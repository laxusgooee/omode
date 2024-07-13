import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:omode/components/menu_back_button.dart';

class AlphabetsPage extends StatefulWidget {
  final AudioPlayer player = AudioPlayer();

  AlphabetsPage({super.key}) {
    player.audioCache.prefix = '';
  }

  @override
  State<AlphabetsPage> createState() => _AlphabetsPageState();
}

class _AlphabetsPageState extends State<AlphabetsPage> {
  int seed = 0;

  final String LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10 + MediaQuery.of(context).padding.top, horizontal: 20),
                color: Theme.of(context).colorScheme.inversePrimary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        MenuBackButton()
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Alphabets',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),const SizedBox(height: 15),
                    Text(
                      'Match the correct letter by placing it on the screen',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black45),
                    ),
                    const SizedBox(height: 25),
                    const Expanded(child: Placeholder())
                  ]
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: 130,
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.top, horizontal: 1),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: List.generate(26, (index) {
                  return Center(
                    child: Text(LETTERS[index]),
                  );
                })..shuffle(Random(seed)),
              ),
            )
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    widget.player.dispose();
    
    super.dispose();
  }
}
