import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key, required this.name, required this.image});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Hero(
            tag: name,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: InteractiveViewer(
                        child: Image.network(image, fit: BoxFit.cover))))),
      ),
    );
  }
}
