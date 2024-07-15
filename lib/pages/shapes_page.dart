import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:omode/components/menu_back_button.dart';

const List<String> SHAPES = [
  'triangle',
  'circle',
  'hexagon',
  'square',
];

class ShapesPage extends StatefulWidget {
  final AudioPlayer player = AudioPlayer();

  ShapesPage({super.key}) {
    player.audioCache.prefix = '';
  }

  @override
  State<ShapesPage> createState() => _ShapesPageState();
}

class _ShapesPageState extends State<ShapesPage> {
  int seed = 0;
  
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
                      'Shapes',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),const SizedBox(height: 15),
                    Text(
                      'Match the correct shape by placing it on the screen',
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
              width: 100,
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.top, horizontal: 10),
              child: Column(children: [
                IconButton(
                  onPressed: () => {

                  },
                  iconSize: 44,
                  icon: Icon(Icons.refresh)
                ),
                const SizedBox(height: 35),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(SHAPES.length, (index) {
                      return Draggable(
                        data: index,
                        feedback: Container(
                          transform: Matrix4.translationValues(-25.0, -35.0, 0.0),
                          child: Column(children: [
                            Image(
                              width: 150,
                              image: AssetImage('lib/assets/images/shapes/${SHAPES[index]}.png')
                            ),
                          ],),
                        ),
                        child: Center(
                          child: Column(children: [
                            Image(width: 68, image: AssetImage('lib/assets/images/shapes/${SHAPES[index]}.png')),
                            Text(SHAPES[index], textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),)
                          ],),
                        ),
                      );
                    })..shuffle(Random(seed)),
                  )
                ),
                const SizedBox(height: 25)
              ])
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
