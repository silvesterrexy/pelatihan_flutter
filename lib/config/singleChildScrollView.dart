// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';

Widget singleChildScrollView(Widget wD, int sizedBox1, int sizedBox2) {
  return SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    child: Column(
      children: [
        SizedBox(
          height: sizedBox1 * SizeConfig.imageSizeMultiplier,
        ),
        wD,
        SizedBox(
          height: sizedBox2 * SizeConfig.imageSizeMultiplier,
        ),
      ],
    ),
  );
}
