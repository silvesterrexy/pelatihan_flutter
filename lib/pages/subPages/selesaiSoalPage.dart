// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/dataSource/getNilaiDataSoruce.dart';
import 'package:pelatihan_flutter/models/getNilaiResponse.dart';

class SelesaiSoalPage extends StatefulWidget {
  const SelesaiSoalPage({
    super.key,
    required this.exerciseId,
    required this.email,
    required this.nama,
  });

  final String exerciseId;
  final String email;
  final String nama;

  @override
  State<SelesaiSoalPage> createState() => _SelesaiSoalPageState();
}

class _SelesaiSoalPageState extends State<SelesaiSoalPage> {
  final getNilaiRemoteDataSource = GetNilaiRemoteDataSource();
  GetNilaiResponse? getNilaiResponse;
//DISINI CEK NILAI

  @override
  void initState() {
    getNilai();
    super.initState();
  }

  Future getNilai() async {
    getNilaiResponse = await getNilaiRemoteDataSource.getData(
      widget.exerciseId,
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
              // centerTitle: false,
              title: GestureDetector(
                onTap: () {
                  Routes().mainMenuInitialPageRoute(
                    widget.email,
                    widget.nama,
                    0,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.xmark,
                      size: 4.0 * SizeConfig.imageSizeMultiplier,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2 * SizeConfig.imageSizeMultiplier,
                    ),
                    Text(
                      "Tutup",
                      style: TextStyleRegullarLight(
                        color: Colors.white,
                        size: 1.65 * SizeConfig.textMultiplier,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: const Color(0xFF3A7FD5),
          body: Container(
            margin: EdgeInsets.only(
              left: 5 * SizeConfig.imageSizeMultiplier,
              right: 5 * SizeConfig.imageSizeMultiplier,
            ),
            width: 100 * SizeConfig.imageSizeMultiplier,
            alignment: Alignment.topCenter,
            color: const Color(0xFF3A7FD5),
            child: (getNilaiResponse == null)
                ? Container(
                    width: 90 * SizeConfig.imageSizeMultiplier,
                    margin: EdgeInsets.only(
                      top: 0 * SizeConfig.imageSizeMultiplier,
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40 * SizeConfig.imageSizeMultiplier,
                          width: 90 * SizeConfig.imageSizeMultiplier,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : futureBuilderRegister(),
          ),
        ),
      ),
    );
  }

  Widget used(String nilai) {
    return Column(
      children: [
        Text(
          "Selamat",
          style: TextStyleRegullarLight(
            size: 2.5 * SizeConfig.textMultiplier,
            color: Colors.white,
          ),
        ),
        Text(
          "Kamu telah menyelesaikan Kuiz ini",
          style: TextStyleRegullarLight(
            size: 1.5 * SizeConfig.textMultiplier,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 10 * SizeConfig.imageSizeMultiplier,
        ),
        Container(
          height: 30 * SizeConfig.imageSizeMultiplier,
          width: 30 * SizeConfig.imageSizeMultiplier,
          margin: EdgeInsets.only(
            top: 4 * SizeConfig.imageSizeMultiplier,
            right: 1 * SizeConfig.imageSizeMultiplier,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.nilai),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 10 * SizeConfig.imageSizeMultiplier,
        ),
        Text(
          "Nilai kamu : ",
          style: TextStyleRegullarLight(
            size: 1.5 * SizeConfig.textMultiplier,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 10 * SizeConfig.imageSizeMultiplier,
        ),
        Text(
          nilai,
          style: TextStyleRegullarLight(
            size: 6.5 * SizeConfig.textMultiplier,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  FutureBuilder futureBuilderRegister() {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 0))
          .then((value) => getNilaiResponse),
      // future: _futureKaryawan,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final email = getNilaiResponse?.data?.result?.jumlahScore;
          return used(email!);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default, show a loading spinner.
        return Container(
          width: 90 * SizeConfig.imageSizeMultiplier,
          margin: EdgeInsets.only(
            top: 0 * SizeConfig.imageSizeMultiplier,
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40 * SizeConfig.imageSizeMultiplier,
                width: 90 * SizeConfig.imageSizeMultiplier,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
        // return const CircularProgressIndicator();
      },
    );
  }
}
