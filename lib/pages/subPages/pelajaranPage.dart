// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pelatihan_flutter/component/pelajaranComponent.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/config/singleChildScrollView.dart';
import 'package:pelatihan_flutter/dataSource/courseRemoteDataSource.dart';
import 'package:pelatihan_flutter/models/courseResponse.dart';

class PelajaranPage extends StatefulWidget {
  const PelajaranPage({
    super.key,
    required this.email,
    required this.nama,
  });

  final String email;
  final String nama;

  @override
  State<PelajaranPage> createState() => _PelajaranPageState();
}

class _PelajaranPageState extends State<PelajaranPage> {
  final courseRemoteDataSource = CourseRemoteDataSource();
  CourseResponse? courseResponse;

  @override
  void initState() {
    // getBanner();
    getCourse();
    super.initState();
  }

  Future getCourse() async {
    courseResponse = await courseRemoteDataSource.getCourse(widget.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      right: false,
      left: false,
      bottom: false,
      top: false,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(6.5 * SizeConfig.heightMultiplier),
            child: AppBar(
              shadowColor: Colors.grey.shade200,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent, // <-- SEE HERE
                statusBarIconBrightness:
                    Brightness.light, //<-- For Android SEE HERE (dark icons)
                statusBarBrightness:
                    Brightness.dark, //<-- For iOS SEE HERE (dark icons)
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: const Color(0xFF3A7FD5),
              centerTitle: false,
              title: appBarContent(),
            ),
          ),
          backgroundColor: const Color(0xFFF0F3F5),
          body: Container(
            margin: EdgeInsets.only(
              left: 5 * SizeConfig.imageSizeMultiplier,
              right: 5 * SizeConfig.imageSizeMultiplier,
            ),
            width: 100 * SizeConfig.imageSizeMultiplier,
            alignment: Alignment.topCenter,
            color: const Color(0xFFF0F3F5),
            child: singleChildScrollView(
              Column(
                children: [
                  courseResponseListView(),
                  // PelajaranComponent(
                  //   title: "Matematika",
                  //   image: Images.mtk,
                  // ),
                  // PelajaranComponent(
                  //   title: "Fisika",
                  //   image: Images.fisika,
                  // ),
                  // PelajaranComponent(
                  //   title: "Kimia",
                  //   image: Images.kimia,
                  // ),
                  // PelajaranComponent(
                  //   title: "Biologi",
                  //   image: Images.biologi,
                  // ),
                  // PelajaranComponent(
                  //   title: "Bahasa Indonesia",
                  //   image: Images.bahasa,
                  // ),
                  // PelajaranComponent(
                  //   title: "Bahasa Inggris",
                  //   image: Images.inggris,
                  // ),
                ],
              ),
              0,
              20,
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Routes().homePageRoute(
                  widget.email,
                  widget.nama,
                );
              },
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                size: 4.0 * SizeConfig.imageSizeMultiplier,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 4 * SizeConfig.imageSizeMultiplier,
            ),
            Text(
              "Pilih Pelajaran",
              style: TextStyleBoldLight(
                size: 2.5 * SizeConfig.textMultiplier,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget courseResponseListView() {
    return (courseResponse == null)
        ? Container(
            width: 90 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              top: 5 * SizeConfig.imageSizeMultiplier,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 80 * SizeConfig.imageSizeMultiplier,
                  width: 90 * SizeConfig.imageSizeMultiplier,
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
          )
        : Container(
            width: 90 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              top: 5 * SizeConfig.imageSizeMultiplier,
              // bottom: 20 * SizeConfig.imageSizeMultiplier,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 180 * SizeConfig.imageSizeMultiplier,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: courseResponse?.data?.length,
                    //itemCount: 3,
                    itemBuilder: (context, index) {
                      final course = courseResponse?.data?[index];
                      return PelajaranComponentFetch(
                        title: course!.courseName!,
                        image: course.urlCover.toString(),
                        jumlahMateri: course.jumlahMateri!,
                        jumlahDone: course.jumlahDone!,
                        progress: course.progress!,
                        from: "PELAJARAN-PAGE",
                        courseId: course.courseId.toString(),
                        email: widget.email,
                        nama: widget.nama,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
