// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/dataSource/updateRemoteDataSource.dart';
import 'package:pelatihan_flutter/models/updateResponse.dart';

class EditDataPage extends StatefulWidget {
  const EditDataPage({
    super.key,
    required this.email,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.kelas,
    required this.namaSekolah,
  });

  final String email;
  final String namaLengkap;
  final String jenisKelamin;
  final String kelas;
  final String namaSekolah;

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final updateUserRemoteDataSource = UpdateUserRemoteDataSource();
  UpdateUserResponse? updateUserResponse;
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

  Future update(
    String namaLengkap,
    String email,
    String namaSekolah,
    String kelas,
    String gender,
    String jenjang,
  ) async {
    updateUserResponse = await updateUserRemoteDataSource.update(
      namaLengkap,
      email,
      namaSekolah,
      kelas,
      gender,
      jenjang,
    );
    setState(() {});
  }

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _email = widget.email;
    _namaLengkap = widget.namaLengkap;
    _jenisKelamin = widget.jenisKelamin;
    _kelas = widget.kelas;
    _namaSekolah = widget.namaSekolah;

    var data = int.parse(_kelas!);
    if (data > 1 && data <= 6) {
      _jenjang = "SD";
    } else if (data > 6 && data <= 9) {
      _jenjang = "SMP";
    } else if (data > 9 && data <= 12) {
      _jenjang = "SMA";
    }

    if (widget.jenisKelamin == "Laki-Laki") {
      tappedL = true;
      tappedP = false;
    } else {
      tappedL = false;
      tappedP = true;
    }
    dropdownvalue = widget.kelas;
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
              centerTitle: true,
              title: Text(
                "Edit Akun",
                style: TextStyleBoldLight(
                  size: 2.5 * SizeConfig.textMultiplier,
                  color: Colors.white,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  Routes().mainMenuInitialPageRoute(
                    widget.email,
                    widget.namaLengkap,
                    2,
                  );
                },
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 4.0 * SizeConfig.imageSizeMultiplier,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          backgroundColor: const Color(0xFFF0F3F5),
          body: Container(
            margin: EdgeInsets.only(
              left: 0 * SizeConfig.imageSizeMultiplier,
              right: 0 * SizeConfig.imageSizeMultiplier,
            ),
            width: 100 * SizeConfig.imageSizeMultiplier,
            alignment: Alignment.topCenter,
            color: const Color(0xFFF0F3F5),
            child: Container(
              color: const Color(0xFFF0F3F5),
              child: (updateUserResponse == null)
                  ? mainForm()
                  : futureBuilderUpdate(),
            ),
          ),
        ),
      ),
    );
  }

  Widget mainForm() {
    return Container(
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
              SizedBox(
                height: 6.5 * SizeConfig.imageSizeMultiplier,
              ),
              button(
                const Color(0xFF3A7FD5),
                "Perbaharui Data",
                Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget formData() {
    return Column(
      children: [
        textForm("Nama Lengkap", widget.namaLengkap, "nama"),
        textForm("Email", widget.email, "email"),
        selectBox("Jenis Kelamin", "Laki-Laki", "Perempuan"),
        dropDownList("Kelas"),
        textForm("Nama Sekolah", widget.namaSekolah, "nama_sekolah"),
      ],
    );
  }

  Widget textForm(String title, String hint, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 5 * SizeConfig.imageSizeMultiplier,
            bottom: 1 * SizeConfig.imageSizeMultiplier,
          ),
          child: Text(
            title,
            style: TextStyleRegullarLight(
              color: Colors.black.withOpacity(0.5),
              size: 1.55 * SizeConfig.textMultiplier,
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
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                width: 0.1 * SizeConfig.imageSizeMultiplier,
                color: Colors.grey,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              readOnly: (key == "email") ? true : false,
              initialValue: (key == "email")
                  ? widget.email
                  : (key == "nama")
                      ? widget.namaLengkap
                      : widget.namaSekolah,
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
                color: (key == "email")
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.9),
                fontSize: 1.55 * SizeConfig.textMultiplier,
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
            top: 5 * SizeConfig.imageSizeMultiplier,
            bottom: 1 * SizeConfig.imageSizeMultiplier,
          ),
          child: Text(
            title,
            style: TextStyleRegullarLight(
              color: Colors.black.withOpacity(0.5),
              size: 1.55 * SizeConfig.textMultiplier,
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
            top: 5 * SizeConfig.imageSizeMultiplier,
            bottom: 1 * SizeConfig.imageSizeMultiplier,
          ),
          child: Text(
            title,
            style: TextStyleRegullarLight(
              color: Colors.black.withOpacity(0.5),
              size: 1.55 * SizeConfig.textMultiplier,
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
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                width: 0.1 * SizeConfig.imageSizeMultiplier,
                color: Colors.grey,
              ),
            ),
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
                  fontSize: 1.5 * SizeConfig.textMultiplier,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
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
                      fontSize: 1.5 * SizeConfig.textMultiplier,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                );
              }).toList(),
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
        setState(() {
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
            update(
              _namaLengkap,
              _email,
              _namaSekolah,
              _kelas!,
              _jenisKelamin,
              _jenjang,
            );
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 10 * SizeConfig.imageSizeMultiplier,
        width: 93 * SizeConfig.imageSizeMultiplier,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.15 * SizeConfig.imageSizeMultiplier,
            color: Colors.indigo,
          ),
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
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

  FutureBuilder futureBuilderUpdate() {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 250))
          .then((value) => updateUserResponse),
      // future: _futureKaryawan,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final email = updateUserResponse?.data?.userEmail;
          final nama = updateUserResponse?.data?.userName;
          //SET TO LOCAL STORAGE

          return suksesUpdate();
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

  Widget suksesUpdate() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      height: 85 * SizeConfig.imageSizeMultiplier,
      child: Center(
        child: Column(
          children: [
            Container(
              height: 35 * SizeConfig.imageSizeMultiplier,
              width: 85 * SizeConfig.imageSizeMultiplier,
              margin: EdgeInsets.only(
                top: 4 * SizeConfig.imageSizeMultiplier,
                right: 1 * SizeConfig.imageSizeMultiplier,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.soalSelesai),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 2 * SizeConfig.imageSizeMultiplier,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Berhasil Melakukan Pembaharuan Data",
                    style: TextStyleSemiBoldLight(
                      color: Colors.black,
                      size: 1.65 * SizeConfig.textMultiplier,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // width: 100 * SizeConfig.imageSizeMultiplier,
              // height: 20 * SizeConfig.imageSizeMultiplier,
              margin: EdgeInsets.only(
                top: 1 * SizeConfig.imageSizeMultiplier,
                bottom: 5 * SizeConfig.imageSizeMultiplier,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Terimakasih Telah Melakukan Pembaruan Data",
                    style: TextStyleSemiBoldLight(
                      color: const Color(0xFF9C9C9C),
                      size: 1.5 * SizeConfig.textMultiplier,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
