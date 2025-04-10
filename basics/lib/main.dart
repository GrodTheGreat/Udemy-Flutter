import 'package:flutter/material.dart';

import 'package:basics/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors: [
            const Color.fromARGB(255, 26, 2, 80),
            const Color.fromARGB(255, 45, 7, 98),
          ],
        ),
      ),
    ),
  );
}
