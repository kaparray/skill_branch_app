import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProgressBottomSheet extends StatelessWidget {
  ProgressBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.grey,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          value: null,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
