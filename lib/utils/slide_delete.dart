  import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget slideRightBackground() {
    return Container(
      decoration: BoxDecoration(color: Colors.red, borderRadius: radius(20)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: primaryTextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
            20.width,
          ],
        ),
      ),
    );
  }