import 'package:flutter/material.dart';

class MyTonalFilledButton extends StatelessWidget {
  final IconData iconData;
  final String text;

  const MyTonalFilledButton({
    super.key,
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FilledButton.tonal(
      onPressed: () {},
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: Row(
        children: [
          Icon(
            iconData,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(text, style: Theme.of(context).textTheme.titleMedium!),
        ],
      ),
    );
  }
}
