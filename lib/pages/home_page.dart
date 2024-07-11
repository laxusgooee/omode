import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omode/components/avatar.dart';
import 'package:omode/components/menu_card.dart';


class HomePage extends StatefulWidget {
  final String? photo;
  HomePage({super.key}): photo = FirebaseAuth.instance.currentUser?.photoURL;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;

  void _onTabChanged() {
    print(FirebaseAuth.instance.currentUser);
    setState(() {
      _tabIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Avatar(photo: FirebaseAuth.instance.currentUser?.photoURL)
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.search,
                  size: 27,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 20),
                child: Icon(
                  Icons.segment,
                  size: 27,
                ),
              ),
            ],
          ),
      ),
      
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: Theme.of(context).textTheme.headlineSmall
                  ),
                  Text (
                    FirebaseAuth.instance.currentUser?.displayName ?? 'Little One',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
                      fontWeight: FontWeight.w800
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  MenuCard(title: 'Numbers', icon: "lib/assets/images/numbers.png"),
                  MenuCard(title: 'Letters', icon: "lib/assets/images/letters.png"),
                  MenuCard(title: 'Shapes', icon: "lib/assets/images/shapes.png"),
                  MenuCard(title: 'Animals', icon: "lib/assets/images/animals.png"),
                  MenuCard(title: 'Colors', icon: "lib/assets/images/colors.png"),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () => _onTabChanged(),
          child: const Icon(Icons.home),
        ),
    );
  }
}

