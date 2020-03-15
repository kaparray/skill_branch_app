import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';

typedef Future<bool> LikeFunc();

class LikeButton extends StatefulWidget {
  LikeButton({this.feedBloc, this.index});

  final FeedBloc feedBloc;
  final int index;

  @override
  State<StatefulWidget> createState() {
    return LikeButtonState();
  }
}

class LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await widget.feedBloc.likePhoto(widget.index);
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
                color: widget.feedBloc.likedByUser(widget.index) ? Colors.red : Colors.black,
              ),
              SizedBox(width: 4.21),
              Text(
                widget.feedBloc.likes(widget.index).toString(),
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
