// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';

class PaketSoalComponent extends StatelessWidget {
  const PaketSoalComponent({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Routes().soalRoute(title);
      },
      child: Container(
        width: 42 * SizeConfig.imageSizeMultiplier,
        padding: EdgeInsets.all(
          3 * SizeConfig.imageSizeMultiplier,
        ),
        margin: EdgeInsets.only(
          top: 4 * SizeConfig.imageSizeMultiplier,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F7F8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(
                    3 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Container(
                    height: 6 * SizeConfig.imageSizeMultiplier,
                    width: 6 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2 * SizeConfig.imageSizeMultiplier,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleSemiBoldLight(
                    size: 1.5 * SizeConfig.textMultiplier,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "0 / 50 Soal",
                  style: TextStyleRegullarLight(
                    size: 1.35 * SizeConfig.textMultiplier,
                    color: Colors.black54,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PaketSoalComponentFetch extends StatelessWidget {
  const PaketSoalComponentFetch({
    super.key,
    required this.title,
    required this.exerciseTitle,
    required this.image,
    required this.from,
    required this.courseId,
    required this.exerciseId,
    required this.email,
    required this.nama,
    required this.jumlahDone,
    required this.jumlahSoal,
  });
  final String title;
  final String image;
  final String from;
  final String courseId;
  final String exerciseTitle;
  final String exerciseId;
  final String email;
  final String nama;
  final int jumlahDone;
  final String jumlahSoal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (jumlahDone == int.parse(jumlahSoal)) {
          Routes().soalSelesaiRoute(exerciseId, email, nama);
        } else {
          Routes().kerjakanSoalRoute(
            title,
            from,
            exerciseId,
            exerciseTitle,
            courseId,
            email,
            nama,
          );
        }
      },
      child: Container(
        // width: 42 * SizeConfig.imageSizeMultiplier,
        // height: 100 * SizeConfig.imageSizeMultiplier,
        padding: EdgeInsets.all(
          3 * SizeConfig.imageSizeMultiplier,
        ),
        margin: EdgeInsets.only(
          top: 4 * SizeConfig.imageSizeMultiplier,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F7F8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(
                    3 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Container(
                    height: 6 * SizeConfig.imageSizeMultiplier,
                    width: 6 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4 * SizeConfig.imageSizeMultiplier,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 100 * SizeConfig.imageSizeMultiplier,
                  // width: 40 * SizeConfig.imageSizeMultiplier,
                  child: Text(
                    exerciseTitle,
                    style: TextStyleSemiBoldLight(
                      size: 1.5 * SizeConfig.textMultiplier,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "$jumlahDone / $jumlahSoal Soal",
                  style: TextStyleRegullarLight(
                    size: 1.35 * SizeConfig.textMultiplier,
                    color: Colors.black54,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
