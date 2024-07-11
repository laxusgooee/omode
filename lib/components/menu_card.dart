import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String icon;

  const MenuCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(icon),
              height: 80,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              '($title)',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                color: Colors.grey
              )
            )
          ],
        ),
      )),
    );
  }
}