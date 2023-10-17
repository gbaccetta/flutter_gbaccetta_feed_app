import 'package:flutter/material.dart';

class ScreenLoaderWidget extends StatelessWidget {
  const ScreenLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white70,
      child: SizedBox.expand(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
