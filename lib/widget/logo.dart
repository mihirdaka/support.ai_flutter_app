import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.alt_route_rounded, size: 140, color: Colors.white),
        Text(
          'Support.ai',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
