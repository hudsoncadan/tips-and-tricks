import 'package:flutter/material.dart';

class CardInfoWidget extends StatelessWidget {
  final IconData icons;
  final String title;
  final String value;

  const CardInfoWidget({
    Key? key,
    required this.icons,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(icons, color: Theme.of(context).textTheme.caption?.color),
            Text(title, style: Theme.of(context).textTheme.caption),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
