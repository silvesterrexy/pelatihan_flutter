// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0 * SizeConfig.heightMultiplier),
            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent, // <-- SEE HERE
                statusBarIconBrightness:
                    Brightness.light, //<-- For Android SEE HERE (dark icons)
                statusBarBrightness:
                    Brightness.light, //<-- For iOS SEE HERE (dark icons)
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: false,
            ),
          ),
          backgroundColor: const Color(0xFFF0F3F5),
          body: Stack(
            children: [
              mainPage(),
              Container(
                margin: EdgeInsets.only(
                  bottom: 10 * SizeConfig.imageSizeMultiplier,
                ),
                child: Center(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Routes().registerPage();
                          },
                          child: button(
                            Colors.white,
                            Images.googleLogo,
                            "Daftar Dengan Google",
                            Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4.5 * SizeConfig.imageSizeMultiplier,
                        ),
                        GestureDetector(
                          onTap: () {
                            Routes().login2Route();
                          },
                          child: button(
                            const Color(0xFF3A7FD5),
                            Images.googleLogo,
                            "Masuk Dengan Email",
                            Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainPage() {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(
        top: (Platform.isAndroid)
            ? 15 * SizeConfig.imageSizeMultiplier
            : 15 * SizeConfig.imageSizeMultiplier,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 8 * SizeConfig.imageSizeMultiplier,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyleBoldLight(
                        size: 2.75 * SizeConfig.textMultiplier,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 50 * SizeConfig.imageSizeMultiplier,
            width: 50 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              top: 10 * SizeConfig.imageSizeMultiplier,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.loginIlustration),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10 * SizeConfig.imageSizeMultiplier,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Selamat Datang",
                      style: TextStyleSemiBoldLight(
                        size: 2.0 * SizeConfig.textMultiplier,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Selamat Datang di Aplikasi Widya Edu\nAplikasi Latihan dan Konsultasi Soal",
                      style: TextStyleRegullarLight(
                        size: 1.5 * SizeConfig.textMultiplier,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 5 * SizeConfig.imageSizeMultiplier,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget button(Color bgColor, String image, String text, Color textColor) {
    return Container(
      alignment: Alignment.center,
      height: 8 * SizeConfig.imageSizeMultiplier,
      width: 50 * SizeConfig.imageSizeMultiplier,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.15 * SizeConfig.imageSizeMultiplier,
          color: Colors.indigo,
        ),
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(2.0, 2.0), //(x,y)
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4 * SizeConfig.imageSizeMultiplier,
            width: 4 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              right: 2 * SizeConfig.imageSizeMultiplier,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyleRegullarLight(
              size: 1.25 * SizeConfig.textMultiplier,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
