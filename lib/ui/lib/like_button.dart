import 'package:flutter/material.dart';

typedef Future<bool> LikeFunc();

class LikeButton extends StatefulWidget {
  LikeButton({this.likeCount, this.isLiked, this.likePhoto});

  final int likeCount;
  final bool isLiked;
  final LikeFunc likePhoto;

  @override
  State<StatefulWidget> createState() {
    return LikeButtonState();
  }
}

class LikeButtonState extends State<LikeButton> {
  int likeCount;
  bool isLiked;

  @override
  void initState() {
    super.initState();
    likeCount = widget.likeCount;
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        isLiked = await widget.likePhoto();
        
        setState(() {
          if (isLiked)
            likeCount++;
          else
            likeCount--;
        });
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
                color: isLiked ? Colors.red : Colors.black,
              ),
              SizedBox(width: 4.21),
              Text(
                likeCount.toString(),
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
