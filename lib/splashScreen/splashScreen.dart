// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SharedPreferences.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/dataSource/getUserRemoteDataSource.dart';
import 'package:pelatihan_flutter/models/getUserResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final getUserRemoteDataSource = GetUserRemoteDataSource();
  GetUserResponse? getUserResponse;
  Future<bool> checkerLocalData() async {
    bool statusFinal;
    late bool statusData;
    await SF()
        .getAvailableValue('user_email')
        .then((value) => {statusData = value});

    if (statusData == false) {
      statusFinal = false;
    } else {
      statusFinal = true;
    }
    return statusFinal;
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String?> fetchLocalData() async {
    final SharedPreferences prefs = await _prefs;
    final String? stringVal = prefs.getString("user_email");
    return stringVal;
  }

  Future<String?> getUser(String email) async {
    getUserResponse = await getUserRemoteDataSource.getUser(email);
    final emailResponse = getUserResponse?.data?.userEmail;
    return emailResponse;
  }

  @override
  void initState() {
    if (mounted) {
      checkerLocalData().then(
        (value) => {
          if (value == true)
            {
              fetchLocalData().then(
                (value) async {
                  getUserResponse =
                      await getUserRemoteDataSource.getUser(value!);
                  final emailResponse = getUserResponse?.data?.userEmail;
                  final namaResponse = getUserResponse?.data?.userName;
                  Routes().mainMenuRoute(emailResponse!, namaResponse!);
                },
              ),
            }
          else
            {
              Routes().loginPage(),
            }
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
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
                  Brightness.dark, //<-- For iOS SEE HERE (dark icons)
              // systemNavigationBarColor: ColorsMain.mainColor.withOpacity(0.8),
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: false,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.bgSplashScreen),
              fit: BoxFit.cover,
            ),
          ),
          // child: Center(
          //   child: Stack(
          //     children: [
          //       Text("load"),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
