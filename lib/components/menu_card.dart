import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onPressed;

  const MenuCard({super.key, this.onPressed, required this.title, required this.icon});

  void onTap() {
    if (onPressed != null) {
      onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
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
      ),
    );
  }
}