
import 'package:flutter/material.dart';



class HeadingTwo extends StatelessWidget {
  final String data;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? backGroundColor;


  const HeadingTwo({
    super.key, required this.data, this.fontWeight, this.fontSize, this.color, this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final sizeH=MediaQuery.sizeOf(context).height;
    return Text(
      data,

      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ??  sizeH*.04,
        fontWeight: fontWeight?? FontWeight.w500,
        backgroundColor: backGroundColor,
      ),

    );
  }
}

class HeadingThree extends StatelessWidget {
  final String data;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? backGroundColor;


  const HeadingThree({
    super.key, required this.data, this.fontWeight, this.fontSize, this.color, this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final sizeH=MediaQuery.sizeOf(context).height;
    return Text(
      data,

      style: TextStyle(
        color: color ?? Colors.black ,
        fontSize: fontSize ??  sizeH*.020,
        fontWeight: fontWeight?? FontWeight.w500,
        backgroundColor: backGroundColor,
      ),

    );
  }
}

class HeadingFour extends StatelessWidget {
  final String data;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? backGroundColor;


  const HeadingFour({
    super.key, required this.data, this.fontWeight, this.fontSize, this.color, this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,

      style: TextStyle(
        color: color ?? Colors.black.withOpacity(.5),
        fontSize: fontSize ??  16,
        fontWeight: fontWeight?? FontWeight.w500,
        backgroundColor: backGroundColor,
      ),

    );
  }
}