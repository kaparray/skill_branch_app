import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatefulWidget {
  @override
  State<ErrorDialog> createState() {
    return ErrorDialogState();
  }
}

class ErrorDialogState extends State<ErrorDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12),
          color: Colors.black.withOpacity(0.3),
          width: 50,
          height: 50,
          child: Icon(Icons.close, color: Colors.white),
        ),
      ),
    );
  }
}
