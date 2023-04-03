import "package:flutter/material.dart";

class FullScreenMap extends StatelessWidget {
  const FullScreenMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Box"),
      ),
      body: const Center(
        child: Text(
          'Hola Mundo',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
