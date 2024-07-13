import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NumbersPage extends StatefulWidget {
  NumbersPage({super.key});

  final List choice =  List.generate(10, (index) => index + 1);

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  
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
                        SizedBox(
                          child: IconButton(
                            iconSize: 35,
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => context.pop(),
                          ),
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
                      'lorem ipsium dolor et marimus valur ceter, cet urirum colom vartor',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black45),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: NumberDisplay(number: 4),
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
                    return TextButton(
                      child: Number(number: index + 1,),
                      onPressed: () => print(index + 1),
                    );
                  }),
                ),
              ),
            )
          ],
        )
      )
    );
  }
}

class Number extends StatelessWidget {
  const Number({super.key, required this.number});
  final int number;

  @override
  Widget build(BuildContext context) {
    Center numberImage = Center(
      child: Image(
        image: AssetImage('lib/assets/images/numbers/$number-bw.png'),
        fit: BoxFit.contain
      ),
    );
    
    return Draggable<int>(
      data: number,
      feedback: Center(
        child: Image(
          image: AssetImage('lib/assets/images/numbers/$number.png'),
          width: 90,
          fit: BoxFit.contain
        ),
      ),
      childWhenDragging: numberImage,
      child: numberImage,
    );
  }
}

class NumberDisplay extends StatelessWidget {
  final int number;

  const NumberDisplay({super.key, required this.number});

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
            fit: BoxFit.contain
          ),
        );
      },
      onWillAcceptWithDetails: (DragTargetDetails<int> details) => details.data == number,
      onAcceptWithDetails: (DragTargetDetails<int> details) {
        print(details.data);
      },
      onLeave: (data) {
        print('rejected: $data');
      },
    );
  }
}
