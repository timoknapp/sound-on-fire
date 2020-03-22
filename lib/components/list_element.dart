import 'package:flutter/material.dart';

class ListElement extends StatelessWidget {
  final Function onClick;
  final String title;
  final String subtitle;
  final String imageUrl;

  ListElement({
    @required this.onClick,
    @required this.title,
    this.subtitle,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return subtitle == null
        ? Card(
            child: ListTile(
              title: Text(title),
              onTap: onClick,
            ),
          )
        : Card(
            child: ListTile(
              leading: imageUrl != null ? Image.network(imageUrl) : null,
              title: Text(title),
              subtitle: Text(subtitle),
              onTap: onClick,
            ),
          );
  }
}
