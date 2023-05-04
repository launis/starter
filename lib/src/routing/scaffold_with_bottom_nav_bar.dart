import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/src/localization/string_hardcoded.dart';
import '/src/routing/app_router.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // used for the currentIndex argument of BottomNavigationBar
  int _selectedIndex = 0;

  void _tap(BuildContext context, int index) {
    if (index == _selectedIndex) {
      // If the tab hasn't changed, do nothing
      return;
    }
    setState(() => _selectedIndex = index);
    if (index == 0) {
      context.goNamed(AppRoute.jobs.name);
    } else if (index == 1) {
      context.goNamed(AppRoute.profile.name);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.work),
              label: 'Jobs'.hardcoded,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profile'.hardcoded,
            ),
          ],
          onTap: (index) => _tap(context, index),
        ),
      );
}
