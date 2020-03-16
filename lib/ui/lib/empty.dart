import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/res/colors.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
          padding: EdgeInsets.all(15),
          color: AppColors.amaranth,
          child: Row(
            children: <Widget>[
              Image.asset('assets/icons/warning.png'),
              const SizedBox(width: 15),
              Text(
                'There was an error loading the feed',
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  height: 15 / 13,
                ),
              ),
            ],
          )),
    );
  }
}
