import 'package:flutter/material.dart';
class NavDrawerHeader extends StatelessWidget {
  final String title;

  const NavDrawerHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/pr.png'),
          ),
        ],
      ),
    );
  }
}

