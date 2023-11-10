// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SharedPreferences.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/dataSource/getUserRemoteDataSource.dart';

import '../../models/getUserResponse.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final getUserRemoteDataSource = GetUserRemoteDataSource();
  GetUserResponse? getUserResponse;

  Future getUser(String email) async {
    getUserResponse = await getUserRemoteDataSource.getUser(email);
    setState(() {});
  }

  Future clearLocalData() async {
    SF().clearAllData("user_email");
    setState(() {});
  }

  @override
  void initState() {
    getUser(widget.email);
    super.initState();
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
            preferredSize: Size.fromHeight(18.5 * SizeConfig.heightMultiplier),
            child: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              shadowColor: Colors.grey.shade200,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent, // <-- SEE HERE
                statusBarIconBrightness:
                    Brightness.light, //<-- For Android SEE HERE (dark icons)
                statusBarBrightness:
                    Brightness.dark, //<-- For iOS SEE HERE (dark icons)
              ),
              automaticallyImplyLeading: false,
              elevation: 2,
              backgroundColor: const Color(0xFF3A7FD5),
              centerTitle: true,
              title: Text(
                "Akun Saya",
                style: TextStyleRegullarLight(
                  size: 2.5 * SizeConfig.textMultiplier,
                  color: Colors.white,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    final nama = getUserResponse?.data?.userName;
                    final email = getUserResponse?.data?.userEmail;
                    final jenisKelamin = getUserResponse?.data?.userGender;
                    final kelas = getUserResponse?.data?.kelas;
                    final namaSekolah = getUserResponse?.data?.userAsalSekolah;
                    if (getUserResponse != null) {
                      Routes().editDataPage(
                        email!,
                        nama!,
                        jenisKelamin!,
                        kelas!,
                        namaSekolah!,
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 4 * SizeConfig.imageSizeMultiplier,
                    ),
                    child: Text(
                      "Edit",
                      style: TextStyleRegullarLight(
                        size: 1.5 * SizeConfig.textMultiplier,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: Container(
                margin: EdgeInsets.only(
                  left: 4 * SizeConfig.imageSizeMultiplier,
                  top: 30 * SizeConfig.imageSizeMultiplier,
                  right: 4 * SizeConfig.imageSizeMultiplier,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (getUserResponse == null)
                        ? loaderAppBar()
                        : futureBuilder1(),
                    Column(
                      children: [
                        Container(
                          height: 12 * SizeConfig.imageSizeMultiplier,
                          width: 12 * SizeConfig.imageSizeMultiplier,
                          margin: EdgeInsets.only(
                            right: 2 * SizeConfig.imageSizeMultiplier,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.profilePicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: const Color(0xFFF0F3F5),
          body: Container(
            color: const Color(0xFFF0F3F5),
            child: Column(
              children: [
                (getUserResponse == null)
                    ? identitasDiriLoader()
                    : futureBuilder2(),
                keluarButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder futureBuilder1() {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 0)).then(
        (value) => getUserResponse,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final nama = getUserResponse?.data?.userName;
          final namaSekolah = getUserResponse?.data?.userAsalSekolah;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama!,
                style: TextStyleRegullarLight(
                  size: 2.25 * SizeConfig.textMultiplier,
                  color: Colors.white,
                ),
              ),
              Text(
                namaSekolah!,
                style: TextStyleRegullarLight(
                  size: 1.5 * SizeConfig.textMultiplier,
                  color: Colors.white,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default, show a loading spinner.
        return loaderAppBar();
        // return const CircularProgressIndicator();
      },
    );
  }

  FutureBuilder futureBuilder2() {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 0))
          .then((value) => getUserResponse),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final nama = getUserResponse?.data?.userName;
          final email = getUserResponse?.data?.userEmail;
          final jenisKelamin = getUserResponse?.data?.userGender;
          final kelas = getUserResponse?.data?.kelas;
          final namaSekolah = getUserResponse?.data?.userAsalSekolah;
          return identitasDiri(
            nama!,
            email!,
            jenisKelamin!,
            kelas!,
            namaSekolah!,
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default, show a loading spinner.
        return identitasDiriLoader();
        // return const CircularProgressIndicator();
      },
    );
  }

  Widget identitasDiri(
    String nama,
    String email,
    String jenisKelamin,
    String kelas,
    String namaSekolah,
  ) {
    return Container(
      margin: EdgeInsets.only(
        top: 5 * SizeConfig.imageSizeMultiplier,
        left: 3 * SizeConfig.imageSizeMultiplier,
        right: 3 * SizeConfig.imageSizeMultiplier,
      ),
      padding: EdgeInsets.only(
        top: 5 * SizeConfig.imageSizeMultiplier,
        left: 5 * SizeConfig.imageSizeMultiplier,
        bottom: 5 * SizeConfig.imageSizeMultiplier,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5.0,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Identitas Diri",
                style: TextStyleRegullarLight(
                  size: 1.75 * SizeConfig.textMultiplier,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6 * SizeConfig.imageSizeMultiplier,
          ),
          loopItem("Nama Lengkap", nama),
          SizedBox(
            height: 3 * SizeConfig.imageSizeMultiplier,
          ),
          loopItem("Email", email),
          SizedBox(
            height: 3 * SizeConfig.imageSizeMultiplier,
          ),
          loopItem("Jenis Kelamin", jenisKelamin),
          SizedBox(
            height: 3 * SizeConfig.imageSizeMultiplier,
          ),
          loopItem("Kelas", kelas),
          SizedBox(
            height: 3 * SizeConfig.imageSizeMultiplier,
          ),
          loopItem("Sekolah", namaSekolah),
        ],
      ),
    );
  }

  Widget loopItem(String text1, String text2) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text1,
              style: TextStyleRegullarLight(
                size: 1.5 * SizeConfig.textMultiplier,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              text2,
              style: TextStyleRegullarLight(
                size: 1.5 * SizeConfig.textMultiplier,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget keluarButton() {
    return GestureDetector(
      onTap: () {
        clearLocalData().then((value) {
          Routes().splashScreenPage();
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 6 * SizeConfig.imageSizeMultiplier,
          left: 3 * SizeConfig.imageSizeMultiplier,
          right: 3 * SizeConfig.imageSizeMultiplier,
        ),
        padding: EdgeInsets.only(
          top: 3 * SizeConfig.imageSizeMultiplier,
          left: 3 * SizeConfig.imageSizeMultiplier,
          bottom: 3 * SizeConfig.imageSizeMultiplier,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5.0,
              offset: const Offset(1, 1),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.arrowRightToBracket,
                  size: 5.0 * SizeConfig.imageSizeMultiplier,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 2 * SizeConfig.imageSizeMultiplier,
                ),
                Text(
                  "Keluar",
                  style: TextStyleRegullarLight(
                    size: 1.75 * SizeConfig.textMultiplier,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loaderAppBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: 10 * SizeConfig.imageSizeMultiplier,
          width: 10 * SizeConfig.imageSizeMultiplier,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 1.9,
          ),
        ),
      ],
    );
  }

  Widget identitasDiriLoader() {
    return Container(
      height: 79.2 * SizeConfig.imageSizeMultiplier,
      margin: EdgeInsets.only(
        top: 5 * SizeConfig.imageSizeMultiplier,
        left: 3 * SizeConfig.imageSizeMultiplier,
        right: 3 * SizeConfig.imageSizeMultiplier,
      ),
      padding: EdgeInsets.only(
        top: 5 * SizeConfig.imageSizeMultiplier,
        left: 5 * SizeConfig.imageSizeMultiplier,
        bottom: 5 * SizeConfig.imageSizeMultiplier,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5.0,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Identitas Diri",
                style: TextStyleRegullarLight(
                  size: 1.75 * SizeConfig.textMultiplier,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6 * SizeConfig.imageSizeMultiplier,
          ),
          Container(
            alignment: Alignment.center,
            height: 20 * SizeConfig.imageSizeMultiplier,
            width: 20 * SizeConfig.imageSizeMultiplier,
            child: const CircularProgressIndicator(
              color: Color(0xFF3A7FD5),
              strokeWidth: 1.9,
            ),
          ),
        ],
      ),
    );
  }
}
