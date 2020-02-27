import 'package:flutter/material.dart';

typedef Future<bool> LikeFunc();

class LikeButton extends StatefulWidget {
  LikeButton({this.onChange, this.isLike = false, this.likeCounter});

  final LikeFunc onChange;
  final bool isLike;
  final int likeCounter;

  @override
  State<StatefulWidget> createState() {
    return LikeButtonState();
  }
}

class LikeButtonState extends State<LikeButton> {
  bool isLike;

  @override
  void initState() {
    super.initState();
    isLike = widget.isLike;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          iconSize: 18,
          icon: Icon(isLike ? Icons.mic_off : Icons.mic_off),
          onPressed: () async {
            isLike = await widget.onChange();
            setState(() {});
          },
        ),
        Text(widget.likeCounter.toString())
      ],
    );
  }
}
