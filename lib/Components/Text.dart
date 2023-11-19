import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatelessWidget{
  const CustomText(this.text, {super.key, this.color, this.size});
  final String text;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign:
        TextAlign.left,
        style: GoogleFonts.aBeeZee(
          color: color ?? Colors.black,
          fontSize: size ?? 24,
        ));
  }
}