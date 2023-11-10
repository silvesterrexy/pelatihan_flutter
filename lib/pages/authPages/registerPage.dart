// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SharedPreferences.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/dataSource/registerRemoteDataSource.dart';
import 'package:pelatihan_flutter/mainMenu/mainMenu.dart';
import 'package:pelatihan_flutter/models/registerResponse.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerRemoteDataSource = RegisterRemoteDataSource();
  RegistrasiResponse? registerResponse;

  Future registrasi(
    String namaLengkap,
    String email,
    String namaSekolah,
    String kelas,
    String gender,
    String jenjang,
  ) async {
    registerResponse = await registerRemoteDataSource.registrasi(
      namaLengkap,
      email,
      namaSekolah,
      kelas,
      gender,
      jenjang,
    );
    setState(() {});
  }

  bool tappedL = false;
  bool tappedP = false;
  String _email = "";
  String _namaLengkap = "";
  String _jenisKelamin = "";
  String? _kelas;
  String _namaSekolah = "";
  String _jenjang = "";

  // Initial Selected Value
  String? dropdownvalue;

  // List of items in our dropdown menu
  var items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];

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
            child: (registerResponse == null)
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
                    "Yuk Isi Data Diri",
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
                              "DAFTAR",
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
        textForm("Nama Lengkap", "Silvester Rexy", "nama"),
        selectBox("Jenis Kelamin", "Laki-Laki", "Perempuan"),
        dropDownList("Kelas"),
        textForm("Nama Sekolah", "nama sekolah", "nama_sekolah"),
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
                  } else if (key == "nama") {
                    _namaLengkap = value.toUpperCase();
                  } else if (key == "nama_sekolah") {
                    _namaSekolah = value.toUpperCase();
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

  Widget selectBox(String title, String box1, String box2) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _jenisKelamin = "Laki-Laki";
                    tappedL = true;
                    tappedP = false;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 42 * SizeConfig.imageSizeMultiplier,
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: (tappedL)
                        ? const Color(0xFF3A7FD5).withOpacity(0.7)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      width: 0.1 * SizeConfig.imageSizeMultiplier,
                      color: Colors.grey,
                    ),
                  ),
                  child: Text(
                    box1,
                    style: TextStyleRegullarLight(
                      color: (tappedL)
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black,
                      size: 1.5 * SizeConfig.textMultiplier,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _jenisKelamin = "Perempuan";
                    tappedL = false;
                    tappedP = true;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 42 * SizeConfig.imageSizeMultiplier,
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: (tappedP)
                        ? const Color(0xFF3A7FD5).withOpacity(0.7)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      width: 0.1 * SizeConfig.imageSizeMultiplier,
                      color: Colors.grey,
                    ),
                  ),
                  child: Text(
                    box2,
                    style: TextStyleRegullarLight(
                      color: (tappedP)
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black,
                      size: 1.5 * SizeConfig.textMultiplier,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget dropDownList(String title) {
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
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     offset: const Offset(0, 0), //(x,y)
            //     blurRadius: 3,
            //   ),
            // ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: DropdownButtonFormField(
              hint: Text(
                "pilih kelas",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.15),
                  fontSize: 1.75 * SizeConfig.textMultiplier,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.white),
                // ),
              ),
              // Initial Value
              value: dropdownvalue,
              // Down Arrow Icon
              icon: const Icon(
                Icons.keyboard_arrow_down,
              ),
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 1.75 * SizeConfig.textMultiplier,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  _kelas = newValue!;
                  var data = int.parse(newValue);
                  if (data > 1 && data <= 6) {
                    _jenjang = "SD";
                  } else if (data > 6 && data <= 9) {
                    _jenjang = "SMP";
                  } else if (data > 9 && data <= 12) {
                    _jenjang = "SMA";
                  }
                });
              },
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
        } else if (_namaLengkap.isEmpty) {
          showCustomToast("Silahkan Isi Nama Lengkap");
        } else if (_jenisKelamin.isEmpty) {
          showCustomToast("Silahkan Pilih Jenis Kelamin");
        } else if (_jenjang.isEmpty) {
          showCustomToast("Silahkan Pilih Kelas");
        } else if (_namaSekolah.isEmpty) {
          showCustomToast("Silahkan Isi Nama Sekolah");
        } else {
          setState(() {
            registrasi(
              _namaLengkap,
              _email,
              _namaSekolah,
              _kelas!,
              _jenisKelamin,
              _jenjang,
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
          .then((value) => registerResponse),
      // future: _futureKaryawan,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final email = registerResponse?.data?.userEmail;
          final nama = registerResponse?.data?.userName;
          final status = registerResponse?.status;
          if (status == 1) {
//SET TO LOCAL STORAGE
            SF().addString('user_email', email!);
            return MainMenu(
              email: email,
              nama: nama!,
            );
          } else {
            final message = registerResponse?.message;
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
