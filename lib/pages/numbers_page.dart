import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NumbersPage extends StatefulWidget {
  final AudioPlayer player = AudioPlayer();

  NumbersPage({super.key}) {
    player.audioCache.prefix = '';
  }

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  int seed = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10 + MediaQuery.of(context).padding.top, left: 20, right: 20),
                color: Theme.of(context).colorScheme.inversePrimary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      //padding: const EdgeInsets.only(bottom: 30),
                      children: [
                        GestureDetector(
                          child: const Icon(Icons.arrow_back, size: 35, color: Colors.black),
                          onTap: () => context.pop(),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Numbers',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Match the correct number by placing it on the screen',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black45),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: NumberDisplay(
                          number: seed+1,
                          onCorrect: () async {
                            widget.player.play(AssetSource('lib/assets/sounds/right.mp3'));
                            
                            if (seed >= 9) {
                              return showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(height: 15),
                                      Text('Yay!', style: Theme.of(context).textTheme.headlineLarge),
                                      const SizedBox(height: 25),
                                      Text('You got all the numbers', style: Theme.of(context).textTheme.titleMedium,),
                                      const SizedBox(height: 10),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            seed = 0;
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          minimumSize: WidgetStateProperty.all(const Size(150, 12)),
                                          foregroundColor: WidgetStateProperty.all(Colors.white),
                                          backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary)
                                        ),
                                        child: const Text('Start again'),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              );
                            }
                            
                            setState(() {
                              seed++;
                            });
                          }
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 15, bottom: MediaQuery.of(context).padding.bottom + 10, left: 20, right: 20),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: List.generate(10, (index) {
                    return Number(number: index + 1,);
                  })..shuffle(Random(seed)),
                ),
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

class Number extends StatelessWidget {
  const Number({super.key, required this.number});
  final int number;

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: number,
      feedback: Container(
        transform: Matrix4.translationValues(-25.0, -35.0, 0.0),
        child: Image(
          image: AssetImage('lib/assets/images/numbers/$number.png'),
          width: 150,
          fit: BoxFit.contain
        ),
      ),
      childWhenDragging: Center(
        child: Image(
          image: AssetImage('lib/assets/images/numbers/$number-bw.png'),
          width: 38,
          fit: BoxFit.contain
        ),
      ),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Image(
            image: AssetImage('lib/assets/images/numbers/$number.png'),
            fit: BoxFit.contain,
            width: 38,
          ),
        ),
      ),
    );
  }
}

class NumberDisplay extends StatelessWidget {
  final int number;
  final Function()? onCorrect;

  const NumberDisplay({super.key, required this.number, this.onCorrect});

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Center(
          child: Image(
            image: AssetImage('lib/assets/images/numbers/$number.png'),
            fit: BoxFit.contain,
            width: 320,
          ),
        );
      },
      onWillAcceptWithDetails: (DragTargetDetails<int> details) => details.data == number,
      onAcceptWithDetails: (DragTargetDetails<int> details) {
        if (onCorrect != null) {
          onCorrect!();
        }
      }
    );
  }
}
