// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:pelatihan_flutter/mainMenu/mainMenu.dart';
import 'package:pelatihan_flutter/pages/authPages/loginPage.dart';
import 'package:pelatihan_flutter/pages/authPages/loginPage2.dart';
import 'package:pelatihan_flutter/pages/authPages/registerPage.dart';
import 'package:pelatihan_flutter/pages/mainPages/homePage.dart';
import 'package:pelatihan_flutter/pages/subPages/editDataPage.dart';
import 'package:pelatihan_flutter/pages/subPages/kerjakanSoalPage.dart';
import 'package:pelatihan_flutter/pages/subPages/pelajaranPage.dart';
import 'package:pelatihan_flutter/pages/subPages/selesaiSoalPage.dart';
import 'package:pelatihan_flutter/pages/subPages/soalPage.dart';
import 'package:pelatihan_flutter/splashScreen/splashScreen.dart';

class Routes {
  splashScreenPage() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await Get.offAll(
        () => const SplashScreen(),
        duration: const Duration(
          milliseconds: 500,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  loginPage() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await Get.offAll(
        () => const LoginPage(),
        duration: const Duration(
          milliseconds: 500,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  registerPage() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await Get.offAll(
        () => const RegisterPage(),
        duration: const Duration(
          milliseconds: 500,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  homePageRoute(String email, String nama) {
    Future.delayed(const Duration(milliseconds: 250), () async {
      await Get.offAll(
        () => HomePage(
          email: email,
          nama: nama,
        ),
        duration: const Duration(
          milliseconds: 250,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  semuaPelajaranRoute(String email, String nama) {
    Future.delayed(const Duration(milliseconds: 250), () async {
      await Get.offAll(
        () => PelajaranPage(
          email: email,
          nama: nama,
        ),
        duration: const Duration(
          milliseconds: 250,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  soalRoute(
    String title,
    String from,
    String courseId,
    String email,
    String nama,
  ) {
    Future.delayed(const Duration(milliseconds: 250), () async {
      await Get.offAll(
        () => SoalPage(
          title: title,
          from: from,
          courseId: courseId,
          email: email,
          nama: nama,
        ),
        duration: const Duration(
          milliseconds: 250,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  kerjakanSoalRoute(
    String title,
    String from,
    String exerciseId,
    String exerciseTitle,
    String courseId,
    String email,
    String nama,
  ) {
    Future.delayed(const Duration(milliseconds: 250), () async {
      await Get.offAll(
        () => KerjakanSoalPage(
          title: title,
          from: from,
          exerciseId: exerciseId,
          exerciseTitle: exerciseTitle,
          courseId: courseId,
          email: email,
          nama: nama,
        ),
        duration: const Duration(
          milliseconds: 250,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  soalSelesaiRoute(
    String exerciseId,
    String email,
    String nama,
  ) {
    Future.delayed(const Duration(milliseconds: 250), () async {
      await Get.offAll(
        () => SelesaiSoalPage(
          exerciseId: exerciseId,
          email: email,
          nama: nama,
        ),
        duration: const Duration(
          milliseconds: 250,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  mainMenuRoute(String email, String nama) {
    Future.delayed(const Duration(milliseconds: 250), () async {
      await Get.offAll(
        () => MainMenu(
          email: email,
          nama: nama,
        ),
        duration: const Duration(
          milliseconds: 250,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  mainMenuInitialPageRoute(String email, String nama, int initialPage) {
    Future.delayed(const Duration(milliseconds: 0), () async {
      await Get.offAll(
        () => MainMenu(
          email: email,
          nama: nama,
          initialPage: initialPage,
        ),
        duration: const Duration(
          milliseconds: 0,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  editDataPage(
    String email,
    String nama,
    String jenisKelamin,
    String kelas,
    String namaSekolah,
  ) {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await Get.offAll(
        () => EditDataPage(
          email: email,
          namaLengkap: nama,
          jenisKelamin: jenisKelamin,
          kelas: kelas,
          namaSekolah: namaSekolah,
        ),
        duration: const Duration(
          milliseconds: 500,
        ),
        transition: Transition.fadeIn,
      );
    });
  }

  login2Route() {
    Future.delayed(const Duration(milliseconds: 250), () async {
      await Get.offAll(
        () => const LoginPage2(),
        duration: const Duration(
          milliseconds: 250,
        ),
        transition: Transition.fadeIn,
      );
    });
  }
}
