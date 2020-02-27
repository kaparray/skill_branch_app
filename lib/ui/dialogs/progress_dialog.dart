import 'package:flutter/material.dart';

class ProgressDialog extends StatefulWidget {
  @override
  State<ProgressDialog> createState() {
    return ProgressDialogState();
  }
}

class ProgressDialogState extends State<ProgressDialog> {
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
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      ),
    );
  }
}
