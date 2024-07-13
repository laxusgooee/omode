import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omode/components/avatar.dart';
import 'package:omode/components/menu_card.dart';

class HomePage extends StatefulWidget {
  final String? photo;
  HomePage({super.key}): photo = FirebaseAuth.instance.currentUser?.photoURL;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onClicked() {
    print(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: Theme.of(context).colorScheme.inversePrimary,
        child: SafeArea(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Avatar(photo: FirebaseAuth.instance.currentUser?.photoURL),
                  const Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 27,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.segment,
                        size: 27,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: Theme.of(context).textTheme.headlineSmall
                ),
                Text (
                  FirebaseAuth.instance.currentUser?.displayName ?? 'Little One',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
                )
              ],
            ),
            const SizedBox(height: 20),
            Flexible(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MenuCard(title: 'Numbers', icon: "lib/assets/images/numbers.png", onPressed: () => context.go('/numbers'),),
                  MenuCard(title: 'Letters', icon: "lib/assets/images/letters.png"),
                  MenuCard(title: 'Shapes', icon: "lib/assets/images/shapes.png"),
                  MenuCard(title: 'Animals', icon: "lib/assets/images/animals.png"),
                  MenuCard(title: 'Colors', icon: "lib/assets/images/colors.png"),
                ],
              ),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () => onClicked(),
          child: const Icon(Icons.settings),
        ),
    );
  }
}

