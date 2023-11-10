// ignore_for_file: file_names

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/config/singleChildScrollView.dart';
import 'package:pelatihan_flutter/dataSource/questionListRemoteDataSource.dart';
import 'package:pelatihan_flutter/dataSource/submitRemoteDataSource.dart';
import 'package:pelatihan_flutter/models/questionListResponse.dart';
import 'package:pelatihan_flutter/models/submitSoalResponse.dart';

class KerjakanSoalPage extends StatefulWidget {
  const KerjakanSoalPage({
    super.key,
    required this.title,
    required this.exerciseTitle,
    required this.from,
    required this.exerciseId,
    required this.courseId,
    required this.email,
    required this.nama,
  });
  final String title;
  final String exerciseTitle;
  final String from;
  final String exerciseId;
  final String courseId;
  final String email;
  final String nama;

  @override
  State<KerjakanSoalPage> createState() => _KerjakanSoalPageState();
}

class _KerjakanSoalPageState extends State<KerjakanSoalPage> {
  final submitSolaRemoteDataSource = SubmitSoalRemoteDataSource();
  SubmitSoalResponse? submitSoalResponse;

  Future submitSoal(
    String email,
    String excerciseID,
    List<String> bankQuestionID,
    List<String> studentAnswer,
  ) async {
    submitSoalResponse = await submitSolaRemoteDataSource.submit(
      email,
      excerciseID,
      bankQuestionID,
      studentAnswer,
    );
    setState(() {});
  }

  int activeStep = 0;
  int nilaiAwal = 0;

  List<String> studentAnswer = [];
  List<String> bankQuestionID = [];

  bool nantiDuluTap = false;
  bool pilihanATap = false;
  bool pilihanBTap = false;
  bool pilihanCTap = false;
  bool pilihanDTap = false;
  bool pilihanETap = false;
  String selectedAnswer = "";
  bool yaSubmitTap = false;

  final questionListRemoteDataSource = QuestionListRemoteDataSource();
  QuestionListResponse? questionListResponse;

  @override
  void initState() {
    getQuestionList();
    super.initState();
  }

  Future getQuestionList() async {
    questionListResponse = await questionListRemoteDataSource.getQuestionList(
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
              centerTitle: true,
              title: appBarContent(),
              leading: GestureDetector(
                onTap: () {
                  Routes().soalRoute(
                    widget.title,
                    widget.from,
                    widget.courseId,
                    widget.email,
                    widget.nama,
                  );
                  // if (widget.from == "MAIN-MENU") {
                  //   Routes().homePageRoute();
                  // } else {
                  //   Routes().semuaPelajaranRoute();
                  // }
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
            child: used(),
          ),
        ),
      ),
    );
  }

  Widget used() {
    return (questionListResponse == null)
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
        : Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 12 * SizeConfig.imageSizeMultiplier,
                alignment: Alignment.center,
                color: Colors.white,
                margin:
                    EdgeInsets.only(top: 0 * SizeConfig.imageSizeMultiplier),
                child: EasyStepper(
                  lineStyle: const LineStyle(
                    lineLength: 30,
                    lineType: LineType.dotted,
                    lineThickness: 1,
                    lineSpace: 20,
                    lineWidth: 10,
                    unreachedLineType: LineType.dotted,
                  ),
                  activeStep: activeStep,
                  activeStepTextColor: Colors.black87,
                  finishedStepTextColor: Colors.black87,
                  internalPadding: 0,
                  showLoadingAnimation: false,
                  stepRadius: 15,
                  showStepBorder: false,
                  steppingEnabled: true,
                  steps: [
                    for (int i = 0; i < questionListResponse!.data!.length; i++)
                      EasyStep(
                        customStep: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF3A7FD5),
                              width: 0.15 * SizeConfig.imageSizeMultiplier,
                            ),
                            color: activeStep >= i
                                ? const Color(0xFF3A7FD5)
                                : Colors.white,
                            // color: activeStep >= i
                            //     ? const Color(0xFF3A7FD5)
                            //     : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            (i + 1).toString(),
                            style: TextStyleRegullarLight(
                              size: 1.5 * SizeConfig.textMultiplier,
                              color:
                                  activeStep >= i ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                  // onStepReached: (index) => setState(() => activeStep = index),
                ),
              ),
              // Text(questionListResponse!.data![activeStep].exerciseIdFk!)
              Expanded(
                child: singleChildScrollView(
                  soalContent(
                    (activeStep + 1).toString(),
                    questionListResponse!.data![activeStep].questionTitle!,
                    questionListResponse!.data![activeStep].optionA!,
                    questionListResponse!.data![activeStep].optionB!,
                    questionListResponse!.data![activeStep].optionC!,
                    questionListResponse!.data![activeStep].optionD!,
                    questionListResponse!.data![activeStep].optionE!,
                    questionListResponse!.data![activeStep].studentAnswer!,
                    questionListResponse!.data![activeStep].bankQuestionId!,
                  ),
                  0,
                  20,
                ),
              ),
            ],
          );
  }

  Widget soalContent(
    String nomorSoal,
    String content,
    String opA,
    String opB,
    String opC,
    String opD,
    String opE,
    String answer,
    String bankQuestionIDInside,
  ) {
    return Container(
      margin: EdgeInsets.only(
        top: 6 * SizeConfig.imageSizeMultiplier,
        left: 5 * SizeConfig.imageSizeMultiplier,
        right: 5 * SizeConfig.imageSizeMultiplier,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Soal Nomor $nomorSoal",
                style: TextStyleRegullarLight(
                  size: 1.65 * SizeConfig.textMultiplier,
                  color: const Color(0xff979797),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2 * SizeConfig.imageSizeMultiplier,
          ),
          HtmlWidget(
            content,
            textStyle: TextStyleRegullarLight(
              size: 1.65 * SizeConfig.textMultiplier,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 7 * SizeConfig.imageSizeMultiplier,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswer = "A";
                pilihanATap = true;
                pilihanBTap = false;
                pilihanCTap = false;
                pilihanDTap = false;
                pilihanETap = false;
              });
            },
            child: pilihanJawaban(
              opA,
              "A",
              answer,
              (pilihanATap)
                  ? const Color(0xFF3A7FD5).withOpacity(0.7)
                  : Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswer = "B";
                pilihanATap = false;
                pilihanBTap = true;
                pilihanCTap = false;
                pilihanDTap = false;
                pilihanETap = false;
              });
            },
            child: pilihanJawaban(
              opE,
              "B",
              answer,
              (pilihanBTap)
                  ? const Color(0xFF3A7FD5).withOpacity(0.7)
                  : Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswer = "C";
                pilihanATap = false;
                pilihanBTap = false;
                pilihanCTap = true;
                pilihanDTap = false;
                pilihanETap = false;
              });
            },
            child: pilihanJawaban(
              opE,
              "C",
              answer,
              (pilihanCTap)
                  ? const Color(0xFF3A7FD5).withOpacity(0.7)
                  : Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswer = "D";
                pilihanATap = false;
                pilihanBTap = false;
                pilihanCTap = false;
                pilihanDTap = true;
                pilihanETap = false;
              });
            },
            child: pilihanJawaban(
              opD,
              "D",
              answer,
              (pilihanDTap)
                  ? const Color(0xFF3A7FD5).withOpacity(0.7)
                  : Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswer = "E";
                pilihanATap = false;
                pilihanBTap = false;
                pilihanCTap = false;
                pilihanDTap = false;
                pilihanETap = true;
              });
            },
            child: pilihanJawaban(
              opE,
              "E",
              answer,
              (pilihanETap)
                  ? const Color(0xFF3A7FD5).withOpacity(0.7)
                  : Colors.white,
            ),
          ),
          SizedBox(
            height: 5 * SizeConfig.imageSizeMultiplier,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (!nantiDuluTap) {
                    // if (selectedAnswer == answer) {
                    //   nilaiAwal = nilaiAwal + 10;
                    // }
                    studentAnswer.add(selectedAnswer);
                    bankQuestionID.add(bankQuestionIDInside);
                  }
                  setState(() {
                    if (activeStep < questionListResponse!.data!.length - 1) {
                      activeStep = activeStep + 1;
                      pilihanATap = false;
                      pilihanBTap = false;
                      pilihanCTap = false;
                      pilihanDTap = false;
                      pilihanETap = false;
                    } else {
                      showModalBottomSheet(
                        isDismissible: true,
                        enableDrag: false,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return bottomModalSheet(
                                nilaiAwal,
                                context,
                                setState,
                              );
                            },
                          );
                        },
                      );
                      debugPrint(studentAnswer.toString());
                      debugPrint(bankQuestionID.toString());
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 2.5 * SizeConfig.imageSizeMultiplier,
                    bottom: 2.5 * SizeConfig.imageSizeMultiplier,
                    left: 8 * SizeConfig.imageSizeMultiplier,
                    right: 8 * SizeConfig.imageSizeMultiplier,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xff3A7FD5),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    (activeStep == questionListResponse!.data!.length - 1)
                        ? "Kumpulin"
                        : "Selanjutnya",
                    style: TextStyleRegullarLight(
                      size: 1.75 * SizeConfig.textMultiplier,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget pilihanJawaban(
    String content,
    String alpabhet,
    String answer,
    Color boxColor,
  ) {
    return Container(
      padding: EdgeInsets.all(
        3 * SizeConfig.imageSizeMultiplier,
      ),
      margin: EdgeInsets.only(
        bottom: 4 * SizeConfig.imageSizeMultiplier,
      ),
      // height: 50,
      // width: 800,
      decoration: BoxDecoration(
        // const Color(0xFF3A7FD5).withOpacity(0.7)
        color: boxColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: const Color(0xffC9C9C9)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$alpabhet.",
                style: TextStyleRegullarLight(
                  size: 1.65 * SizeConfig.textMultiplier,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 5 * SizeConfig.imageSizeMultiplier),
            child: HtmlWidget(
              content,
              textStyle: TextStyleRegullarLight(
                size: 1.65 * SizeConfig.textMultiplier,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarContent() {
    return Text(
      "Latihan Soal",
      style: TextStyleBoldLight(
        size: 2.5 * SizeConfig.textMultiplier,
        color: Colors.white,
      ),
    );
  }

  Widget bottomModalSheet(
      int nilai, BuildContext context, StateSetter setState) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      height: 85 * SizeConfig.imageSizeMultiplier,
      child: Center(
        child: (yaSubmitTap)
            ? SizedBox(
                width: 90 * SizeConfig.imageSizeMultiplier,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 80 * SizeConfig.imageSizeMultiplier,
                      width: 90 * SizeConfig.imageSizeMultiplier,
                      child: const CircularProgressIndicator(
                        color: Color(0xFF3A7FD5),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 1.5 * SizeConfig.imageSizeMultiplier,
                    ),
                    child: Icon(
                      FontAwesomeIcons.gripLines,
                      size: 4.0 * SizeConfig.imageSizeMultiplier,
                      color: const Color(0xFFC4C4C4),
                    ),
                  ),
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
                          "Kumpulkan latihan soal sekarang?",
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
                          "Boleh Langsung kumpulin dong",
                          style: TextStyleSemiBoldLight(
                            color: const Color(0xFF9C9C9C),
                            size: 1.5 * SizeConfig.textMultiplier,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // if (type == "LOCATION") {
                      //   Routes().galeryAccessPermission();
                      // } else if (type == "GALLERY") {
                      //   Routes().cameraAccessPermission();
                      // } else if (type == "CAMERA") {
                      //   Routes().launchPage();
                      // }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 5 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                nantiDuluTap = true;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 7 * SizeConfig.imageSizeMultiplier,
                              width: 38 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFF3A7FD5)),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "Nanti Dulu",
                                  style: TextStyleSemiBoldLight(
                                    size: 1.35 * SizeConfig.textMultiplier,
                                    color: const Color(0xFF3A7FD5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3 * SizeConfig.imageSizeMultiplier,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                yaSubmitTap = true;
                              });
                              // debugPrint(yaSubmitTap.toString());
                              submitSoal(
                                widget.email,
                                widget.exerciseId,
                                bankQuestionID,
                                studentAnswer,
                              ).then((value) {
                                Routes().soalSelesaiRoute(
                                  widget.exerciseId,
                                  widget.email,
                                  widget.nama,
                                );
                              });
                            },
                            child: Container(
                              height: 7 * SizeConfig.imageSizeMultiplier,
                              width: 38 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF3A7FD5),
                              ),
                              child: Center(
                                child: Text(
                                  "Ya",
                                  style: TextStyleSemiBoldLight(
                                    size: 1.35 * SizeConfig.textMultiplier,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
