// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pelatihan_flutter/component/paketSoalComponent.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/config/singleChildScrollView.dart';
import 'package:pelatihan_flutter/dataSource/soalRemoteDataSource.dart';
import 'package:pelatihan_flutter/models/soalResponse.dart';

class SoalPage extends StatefulWidget {
  const SoalPage({
    super.key,
    required this.title,
    required this.from,
    required this.courseId,
    required this.email,
    required this.nama,
  });
  final String title;
  final String from;
  final String courseId;
  final String email;
  final String nama;

  @override
  State<SoalPage> createState() => _SoalPageState();
}

class _SoalPageState extends State<SoalPage> {
  final soalRemoteDataSource = SoalRemoteDataSource();
  SoalResponse? soalResponse;

  @override
  void initState() {
    getSoal();
    super.initState();
  }

  Future getSoal() async {
    soalResponse = await soalRemoteDataSource.getSoal(
      widget.courseId,
      widget.email,
    );
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
              soalResponseListView(),
              // Wrap(
              //   crossAxisAlignment: WrapCrossAlignment.center,
              //   spacing: 4 * SizeConfig.imageSizeMultiplier,
              //   children: [

              //     // PaketSoalComponent(
              //     //   title: "Trigonometri",
              //     //   image: Images.soal,
              //     // ),
              //     // PaketSoalComponent(
              //     //   title: "Aljabar",
              //     //   image: Images.soal,
              //     // ),
              //     // PaketSoalComponent(
              //     //   title: "Matrix",
              //     //   image: Images.soal,
              //     // ),
              //   ],
              // ),
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
                if (widget.from == "MAIN-MENU") {
                  Routes().mainMenuInitialPageRoute(
                    widget.email,
                    widget.nama,
                    0,
                  );
                } else {
                  Routes().semuaPelajaranRoute(
                    widget.email,
                    widget.nama,
                  );
                }
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
              widget.title,
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

  Widget soalResponseListView() {
    return (soalResponse == null)
        ? Container(
            width: 42 * SizeConfig.imageSizeMultiplier,
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
            //width: 42 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              top: 5 * SizeConfig.imageSizeMultiplier,
              // bottom: 20 * SizeConfig.imageSizeMultiplier,
            ),
            child: Column(
              children: [
                (soalResponse!.data!.isNotEmpty)
                    ? SizedBox(
                        height: 180 * SizeConfig.imageSizeMultiplier,
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: soalResponse?.data?.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 2.0 / 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          //itemCount: 3,
                          itemBuilder: (context, index) {
                            final soal = soalResponse?.data?[index];

                            return PaketSoalComponentFetch(
                              exerciseTitle: soal!.exerciseTitle!,
                              title: widget.title,
                              image: Images.soal,
                              from: widget.from,
                              exerciseId: soal.exerciseId!,
                              courseId: widget.courseId,
                              email: widget.email,
                              nama: widget.nama,
                              jumlahSoal: soal.jumlahSoal!,
                              jumlahDone: soal.jumlahDone!,
                            );
                          },
                        ),
                      )
                    : Container(
                        height: 60 * SizeConfig.imageSizeMultiplier,
                        width: 100 * SizeConfig.imageSizeMultiplier,
                        margin: EdgeInsets.only(
                          top: 13 * SizeConfig.imageSizeMultiplier,
                          right: 1 * SizeConfig.imageSizeMultiplier,
                        ),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.soalNotFound),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
              ],
            ),
          );
  }
}
