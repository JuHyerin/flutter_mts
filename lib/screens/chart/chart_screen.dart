import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[200],
      alignment: Alignment.center,
      child: const Text(
        '차트',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }

}
