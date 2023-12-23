import 'package:flutter/material.dart';

class ScreenErrorWidget extends StatelessWidget {
  final String error;
  final String buttonLabel;
  final Function()? onButtonTap;
  const ScreenErrorWidget({
    super.key,
    this.error = 'Ouch 🤕!\n🚨\nThere was an error... 🤦‍♂️',
    this.buttonLabel = 'RETRY',
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          error,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        if (onButtonTap != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
            child: MaterialButton(
              onPressed: onButtonTap,
              child: Text(buttonLabel),
            ),
          ),
          const SizedBox(height: 60),
      ],
    );
  }
}
