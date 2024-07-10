import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';


class ScaffoldBottomBar extends StatefulWidget {
  const ScaffoldBottomBar({super.key, required this.child});
  final Widget child;

  @override
  State<ScaffoldBottomBar> createState() => _ScaffoldBottomBar();
}

class _ScaffoldBottomBar extends State<ScaffoldBottomBar> {
  int _tabIndex = 0;

  void _onTabChanged(int index) {
    if (index == 0) {
      context.go('/');
    } else {
      context.go('/profile');
    }

    setState(() {
      _tabIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.horizontal(left:  Radius.circular(28), right:  Radius.circular(28))
        ),
        height: 48,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavigationItem(
              icon: Icons.home,
              label: 'Home',
              onPressed: () => _onTabChanged(0),
            ),
            NavigationItem(
              icon: Icons.home,
              label: 'Profile',
              onPressed: () => _onTabChanged(1),
            ),
          ],
        ),
      )
    );
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({super.key, required this.label, required this.icon, required this.onPressed, this.isActive = false});

  final String label;
  final IconData icon;
  final bool isActive;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: () => onPressed!(),
    );
  }
  
}
// Widget NavigationItem = TextButton.icon(
//   icon: const Icon(Icons.home),
//   label: const Text('Home'),
//   onPressed: () => _onTabChanged(0),
// );


// backgroundColor: const Color(0xffe0b9f6),
// currentIndex: _tabIndex,
// items: const [
//   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//   BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
// ],