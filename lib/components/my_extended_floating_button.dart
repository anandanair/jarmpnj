import 'package:flutter/material.dart';

class MyExtendedFloatingButton extends StatelessWidget {
  final IconData iconData;
  final String text;

  const MyExtendedFloatingButton({
    super.key,
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      heroTag: null,
      label: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      icon: Icon(
        iconData,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
