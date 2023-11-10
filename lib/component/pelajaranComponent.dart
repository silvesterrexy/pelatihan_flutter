// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';

class PelajaranComponent extends StatelessWidget {
  const PelajaranComponent({
    super.key,
    required this.title,
    required this.image,
    required this.email,
    required this.nama,
  });
  final String title;
  final String image;
  final String email;
  final String nama;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes().soalRoute(title, "coba", "100", email, nama);
      },
      child: Container(
        padding: EdgeInsets.all(
          4 * SizeConfig.imageSizeMultiplier,
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
        child: Row(
          children: [
            Column(
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
                    height: 8 * SizeConfig.imageSizeMultiplier,
                    width: 8 * SizeConfig.imageSizeMultiplier,
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
              width: 2 * SizeConfig.imageSizeMultiplier,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleSemiBoldLight(
                    size: 1.85 * SizeConfig.textMultiplier,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "0 / 50 Paket Latihan Soal",
                  style: TextStyleRegullarLight(
                    size: 1.35 * SizeConfig.textMultiplier,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 2 * SizeConfig.imageSizeMultiplier,
                ),
                Container(
                  // height: 30,
                  width: 65 * SizeConfig.imageSizeMultiplier,
                  child: LinearProgressIndicator(
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    backgroundColor: const Color(0xFF3A7FD5).withOpacity(0.3),
                    color: const Color(0xFF3A7FD5),
                    // // valueColor: Colors.black,
                    // color: Colors.amber,
                    minHeight: 1.5 * SizeConfig.imageSizeMultiplier,
                    // value: 1,
                    value: 0.5,
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

class PelajaranComponentFetch extends StatelessWidget {
  const PelajaranComponentFetch({
    super.key,
    required this.title,
    required this.image,
    required this.jumlahMateri,
    required this.jumlahDone,
    required this.progress,
    required this.from,
    required this.courseId,
    required this.email,
    required this.nama,
  });
  final String title;
  final String image;
  final int jumlahMateri;
  final int jumlahDone;
  final int progress;
  final String from;
  final String courseId;

  final String email;
  final String nama;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes().soalRoute(
          title,
          from,
          courseId,
          email,
          nama,
        );
      },
      child: Container(
        padding: EdgeInsets.all(
          4 * SizeConfig.imageSizeMultiplier,
        ),
        margin: EdgeInsets.only(
          bottom: 4 * SizeConfig.imageSizeMultiplier,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Column(
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
                    height: 8 * SizeConfig.imageSizeMultiplier,
                    width: 8 * SizeConfig.imageSizeMultiplier,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.biologi),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    // child: CachedNetworkImage(
                    //   imageUrl: image,
                    //   placeholder: (context, url) =>
                    //       new CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) =>
                    //       new Icon(Icons.error),
                    // ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 2 * SizeConfig.imageSizeMultiplier,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleSemiBoldLight(
                    size: 1.85 * SizeConfig.textMultiplier,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "$jumlahDone / $jumlahMateri Paket Latihan Soal",
                  style: TextStyleRegullarLight(
                    size: 1.35 * SizeConfig.textMultiplier,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 2 * SizeConfig.imageSizeMultiplier,
                ),
                Container(
                  // height: 30,
                  width: 65 * SizeConfig.imageSizeMultiplier,
                  child: LinearProgressIndicator(
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    backgroundColor: const Color(0xFF3A7FD5).withOpacity(0.3),
                    color: const Color(0xFF3A7FD5),
                    // // valueColor: Colors.black,
                    // color: Colors.amber,
                    minHeight: 1.5 * SizeConfig.imageSizeMultiplier,
                    value: progress.toDouble(),
                    //value: (jumlahMateri / jumlahDone),
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
