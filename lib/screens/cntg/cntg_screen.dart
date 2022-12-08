import 'package:flutter/material.dart';

class CntgScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      alignment: Alignment.center,
      child: const Text(
        '체결',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }
}
