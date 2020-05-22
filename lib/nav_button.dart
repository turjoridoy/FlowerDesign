import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {

  final int index;
  final ValueChanged<int> onTap;
  final Widget child;

  NavButton({this.onTap, this.index, this.child});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
            height: 75.0,
//            color: Colors.red,
            child: child
        ),
      );
  }
}
