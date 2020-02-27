import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoneDialog extends StatefulWidget {
  @override
  State<DoneDialog> createState() {
    return DoneDialogState();
  }
}

class DoneDialogState extends State<DoneDialog> {
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
          child: Icon(Icons.done_all, color: Colors.white,),
        ),
      ),
    );
  }
}
