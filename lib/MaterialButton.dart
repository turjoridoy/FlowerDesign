import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    @required this.onPressed,
    @required this.edgeInsetHorizontal,
    @required this.text,
    @required this.edgeInsetVertical,
    @required this.backColor,
  });

  final GestureTapCallback onPressed;
  final double edgeInsetHorizontal;
  final double edgeInsetVertical;
  final String text;
  final Color backColor;


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: edgeInsetVertical, horizontal: edgeInsetHorizontal),
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8.0),
          child: MaterialButton(
            onPressed: onPressed,
            color: backColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
