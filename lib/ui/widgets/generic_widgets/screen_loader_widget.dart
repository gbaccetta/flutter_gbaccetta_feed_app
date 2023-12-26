import 'package:flutter/material.dart';

class ScreenLoaderWidget extends StatelessWidget {
  const ScreenLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface.withAlpha(125),
      child: const SizedBox.expand(
        child: Center(child: CircularProgressIndicator(
          
        )),
      ),
    );
  }
}
