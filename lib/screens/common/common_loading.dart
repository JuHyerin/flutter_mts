import 'package:flutter/material.dart';

class CommonLoading extends StatelessWidget {
  final double size; // 로딩 크기
  final double strokeWidth; // 로딩 굵기

  CommonLoading({this.size = 30, this.strokeWidth = 3});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(strokeWidth: strokeWidth),
      )
    );
  }
}
