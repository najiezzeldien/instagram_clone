// convert 0x?????? or 0x?????? to Color
import 'package:flutter/material.dart';
import 'package:instagram_clone_course/extentions/string/remove_all.dart';

extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(["0x", "#"]).padLeft(8, "ff"),
          radix: 16,
        ),
      );
}
