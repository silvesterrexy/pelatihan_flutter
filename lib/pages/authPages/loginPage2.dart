// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SharedPreferences.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/dataSource/getUserRemoteDataSource.dart';
import 'package:pelatihan_flutter/dataSource/registerRemoteDataSource.dart';
import 'package:pelatihan_flutter/mainMenu/mainMenu.dart';
import 'package:pelatihan_flutter/models/getUserResponse.dart';
import 'package:pelatihan_flutter/models/registerResponse.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  String _email = "";
  final getUserRemoteDataSource = GetUserRemoteDataSource();
  GetUserResponse? getUserResponse;

  Future getUser(String email) async {
    getUserResponse = await getUserRemoteDataSource.getUser(email);
    setState(() {});
  }

  late FToast fToast;
  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(context);
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
          backgroundColor: const Color(0xFFF0F3F5),
          body: Container(
            color: const Color(0xFFF0F3F5),
            child: (getUserResponse == null)
                ? mainForm()
                : futureBuilderRegister(),
          ),
        ),
      ),
    );
  }

  Widget mainForm() {
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
            preferredSize: Size.fromHeight(12 * SizeConfig.heightMultiplier),
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
                    Brightness.light, //<-- For iOS SEE HERE (dark icons)
              ),
              automaticallyImplyLeading: false,
              elevation: 2,
              backgroundColor: Colors.white,
              centerTitle: false,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Routes().loginPage();
                    },
                    child: Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 5.0 * SizeConfig.imageSizeMultiplier,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2 * SizeConfig.imageSizeMultiplier,
                  ),
                  Text(
                    "Masukkan Email Kamu",
                    style: TextStyleBoldLight(
                      size: 2.75 * SizeConfig.textMultiplier,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: const Color(0xFFF0F3F5),
          body: Container(
            color: const Color(0xFFF0F3F5),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        formData(),
                      ],
                    ),
                  ],
                ),
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
                          SizedBox(
                            height: 4.5 * SizeConfig.imageSizeMultiplier,
                          ),
                          GestureDetector(
                            onTap: () {
                              //Routes().homePageRoute();
                              // Routes().mainMenuRoute();
                            },
                            child: button(
                              const Color(0xFF3A7FD5),
                              "MASUK",
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
      ),
    );
  }

  Widget formData() {
    return Column(
      children: [
        textForm("Email", "silvesterrexyy@gmail.com", "email"),
      ],
    );
  }

  Widget textForm(String title, String hint, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 6 * SizeConfig.imageSizeMultiplier,
            bottom: 1 * SizeConfig.imageSizeMultiplier,
          ),
          child: Text(
            title,
            style: TextStyleSemiBoldLight(
              color: Colors.black,
              size: 1.75 * SizeConfig.textMultiplier,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 0 * SizeConfig.imageSizeMultiplier,
            right: 0 * SizeConfig.imageSizeMultiplier,
            top: 1 * SizeConfig.imageSizeMultiplier,
            bottom: 0 * SizeConfig.imageSizeMultiplier,
          ),
          width: 87 * SizeConfig.imageSizeMultiplier,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              width: 0.1 * SizeConfig.imageSizeMultiplier,
              color: Colors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  if (key == "email") {
                    _email = value.toUpperCase();
                  }
                });
              },
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 1.75 * SizeConfig.textMultiplier,
                fontFamily: 'Poppins-Regular',
              ),
              // => fetchTempatPelayananFilter(value),
              maxLines: 1,
              decoration: InputDecoration.collapsed(
                hintText: "contoh : $hint",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.15),
                  fontSize: 1.75 * SizeConfig.textMultiplier,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.allow(
              //       RegExp("[0-9a-zA-Z ]")),
              // ],
            ),
          ),
        ),
      ],
    );
  }

  Widget button(Color bgColor, String text, Color textColor) {
    return GestureDetector(
      onTap: () {
        if (_email.isEmpty) {
          showCustomToast("Silahkan Isi Email");
        } else {
          setState(() {
            getUser(
              _email,
            );
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 10 * SizeConfig.imageSizeMultiplier,
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
            Text(
              text,
              style: TextStyleSemiBoldLight(
                size: 1.45 * SizeConfig.textMultiplier,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showCustomToast(String info) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red[400]?.withOpacity(0.8),
      ),
      child: Text(
        info,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins-Regular',
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );

    fToast.showToast(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: toast,
      ),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 2),
    );
  }

  FutureBuilder futureBuilderRegister() {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 0))
          .then((value) => getUserResponse),
      // future: _futureKaryawan,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final email = getUserResponse?.data?.userEmail;
          final nama = getUserResponse?.data?.userName;
          final status = getUserResponse?.status;
          if (status == 1) {
            //SET TO LOCAL STORAGE
            SF().addString('user_email', email!);
            return MainMenu(
              email: email,
              nama: nama!,
            );
          } else {
            final message = getUserResponse?.message;
            return Container(
              margin: EdgeInsets.only(
                top: 20 * SizeConfig.imageSizeMultiplier,
              ),
              child: Column(
                children: [
                  Text(
                    message!,
                    style: TextStyleRegullarLight(
                      color: Colors.black,
                      size: 1.75 * SizeConfig.textMultiplier,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      Routes().splashScreenPage();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10 * SizeConfig.imageSizeMultiplier,
                      ),
                      alignment: Alignment.center,
                      height: 10 * SizeConfig.imageSizeMultiplier,
                      width: 35 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.15 * SizeConfig.imageSizeMultiplier,
                          color: Colors.indigo,
                        ),
                        color: const Color(0xFF3A7FD5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
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
                          Text(
                            "Coba Lagi",
                            style: TextStyleSemiBoldLight(
                              size: 1.45 * SizeConfig.textMultiplier,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
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
                child: const CircularProgressIndicator(),
              ),
            ],
          ),
        );
        // return const CircularProgressIndicator();
      },
    );
  }
}
