import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuBackButton extends StatelessWidget {
  const MenuBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(Icons.arrow_back, size: 35, color: Colors.black),
      onTap: () => context.pop(),
    );
  }
}