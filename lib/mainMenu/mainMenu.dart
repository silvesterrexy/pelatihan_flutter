// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/pages/mainPages/diskusiPage.dart';
import 'package:pelatihan_flutter/pages/mainPages/homePage.dart';
import 'package:pelatihan_flutter/pages/mainPages/profilePage.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    super.key,
    required this.email,
    required this.nama,
    this.initialPage = 0,
  });

  final String email;
  final String nama;
  final int initialPage;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  void getIndexPage() {
    setState(() {
      _currentIndex = widget.initialPage;
    });
  }

  int _currentIndex = 0;
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    getIndexPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: [
          HomePage(
            email: widget.email,
            nama: widget.nama,
          ),
          const DiskusiPage(),
          ProfilePage(
            email: widget.email,
          ),
        ][_currentIndex],
        extendBody: true,
        bottomNavigationBar: usedMenu(),
      ),
    );
  }

  Container usedMenu() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.35 * SizeConfig.imageSizeMultiplier,
          color: Colors.white24,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            // const Color(0xFF4E7D96).withOpacity(1),
            // const Color(0xFFb8cbd5).withOpacity(1),
            Colors.white,
            Colors.white,
          ],
        ),
        borderRadius: (Platform.isAndroid)
            ? const BorderRadius.vertical(
                top: Radius.circular(35),
              )
            : const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.2),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
          child: GNav(
            // rippleColor: Colors.grey[300]!,
            // hoverColor: Colors.grey[100]!,
            gap: 0,
            activeColor: const Color(0xFF4E7D96).withOpacity(1),
            iconSize: 23,
            padding: EdgeInsets.symmetric(
              horizontal: 8 * SizeConfig.imageSizeMultiplier,
              vertical: 11,
            ),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.white,
            //color: Colors.black,
            tabs: [
              GButton(
                text: '',
                textStyle: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4E7D96).withOpacity(1),
                  fontSize: 1.75 * SizeConfig.textMultiplier,
                ),
                backgroundGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    // Colors.lightBlue.shade900,
                    // Colors.lightBlue.shade400,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                icon: FontAwesomeIcons.house,
                iconColor: (_currentIndex == 0)
                    ? const Color(0xFF4E7D96).withOpacity(1)
                    : const Color(0xFF4E7D96).withOpacity(0.4),
              ),
              GButton(
                text: '',
                textStyle: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4E7D96).withOpacity(1),
                  fontSize: 1.75 * SizeConfig.textMultiplier,
                ),
                backgroundGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    // Colors.lightBlue.shade900,
                    // Colors.lightBlue.shade400,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                icon: FontAwesomeIcons.solidComment,
                iconColor: (_currentIndex == 1)
                    ? const Color(0xFF4E7D96).withOpacity(1)
                    : const Color(0xFF4E7D96).withOpacity(0.4),
              ),
              GButton(
                text: '',
                textStyle: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4E7D96).withOpacity(1),
                  fontSize: 1.75 * SizeConfig.textMultiplier,
                ),
                backgroundGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    // Colors.lightBlue.shade900,
                    // Colors.lightBlue.shade400,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                icon: FontAwesomeIcons.solidCircleUser,
                iconColor: (_currentIndex == 3)
                    ? const Color(0xFF4E7D96).withOpacity(1)
                    : const Color(0xFF4E7D96).withOpacity(0.4),
                iconSize: 25,
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Container chatBottomBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.35 * SizeConfig.imageSizeMultiplier,
          color: Colors.white24,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            // const Color(0xFF4E7D96).withOpacity(1),
            // const Color(0xFFb8cbd5).withOpacity(1),
            Colors.white,
            Colors.white,
          ],
        ),
        borderRadius: (Platform.isAndroid)
            ? const BorderRadius.vertical(
                top: Radius.circular(35),
              )
            : const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.2),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
          child: GNav(
            // rippleColor: Colors.grey[300]!,
            // hoverColor: Colors.grey[100]!,
            gap: 0,
            activeColor: const Color(0xFF4E7D96).withOpacity(1),
            iconSize: 23,
            padding: EdgeInsets.symmetric(
              horizontal: 8 * SizeConfig.imageSizeMultiplier,
              vertical: 11,
            ),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.black,
            //color: Colors.black,
            tabs: [
              GButton(
                text: '',
                textStyle: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4E7D96).withOpacity(1),
                  fontSize: 1.75 * SizeConfig.textMultiplier,
                ),
                backgroundGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    // Colors.lightBlue.shade900,
                    // Colors.lightBlue.shade400,
                    Colors.grey,
                    Colors.grey,
                  ],
                ),
                icon: FontAwesomeIcons.house,
                iconColor: (_currentIndex == 0)
                    ? const Color(0xFF4E7D96).withOpacity(1)
                    : const Color(0xFF4E7D96).withOpacity(0.4),
              ),
              GButton(
                text: '',
                textStyle: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4E7D96).withOpacity(1),
                  fontSize: 1.75 * SizeConfig.textMultiplier,
                ),
                backgroundGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    // Colors.lightBlue.shade900,
                    // Colors.lightBlue.shade400,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                icon: FontAwesomeIcons.solidComment,
                iconColor: (_currentIndex == 1)
                    ? const Color(0xFF4E7D96).withOpacity(1)
                    : const Color(0xFF4E7D96).withOpacity(0.4),
              ),
              GButton(
                text: '',
                textStyle: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4E7D96).withOpacity(1),
                  fontSize: 1.75 * SizeConfig.textMultiplier,
                ),
                backgroundGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    // Colors.lightBlue.shade900,
                    // Colors.lightBlue.shade400,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                icon: FontAwesomeIcons.solidCircleUser,
                iconColor: (_currentIndex == 3)
                    ? const Color(0xFF4E7D96).withOpacity(1)
                    : const Color(0xFF4E7D96).withOpacity(0.4),
                iconSize: 25,
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
