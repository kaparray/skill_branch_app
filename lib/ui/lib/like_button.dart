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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        isLike = await widget.onChange();
        setState(() {});
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/icons/like.png',
                width: 21,
                height: 18.3,
              ),
              SizedBox(width: 4.21),
              Text(
                widget.likeCounter.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  height: 16 / 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
