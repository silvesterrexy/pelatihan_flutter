// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pelatihan_flutter/bloc/banner_bloc/banner_bloc.dart';
import 'package:pelatihan_flutter/bloc/pelajaran_bloc/pelajaran_bloc.dart';
import 'package:pelatihan_flutter/component/pelajaranComponent.dart';
import 'package:pelatihan_flutter/config/Image.dart';
import 'package:pelatihan_flutter/config/Routes.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/config/TextStyle.dart';
import 'package:pelatihan_flutter/config/singleChildScrollView.dart';
import 'package:pelatihan_flutter/dataSource/bannerRemoteDataSource.dart';
import 'package:pelatihan_flutter/dataSource/courseRemoteDataSource.dart';
import 'package:pelatihan_flutter/models/bannerResponse.dart';
import 'package:pelatihan_flutter/models/courseResponse.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.email,
    required this.nama,
  });

  final String email;
  final String nama;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bannerRemoteDataSource = BannerRemoteDataSource();
  BannerResponse? bannerResponse;

  final courseRemoteDataSource = CourseRemoteDataSource();
  CourseResponse? courseResponse;

  // @override
  // void initState() {
  //   // getBanner();
  //   getCourse().then(
  //     (value) => getBanner(),
  //   );
  //   super.initState();
  // }

  // Future getBanner() async {
  //   bannerResponse = await bannerRemoteDataSource.getBanners();
  //   setState(() {});
  // }

  // Future getCourse() async {
  //   courseResponse = await courseRemoteDataSource.getCourse();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BannerBloc(bannerRemoteDataSource)..add(GetBannerListEvent()),
        ),
        BlocProvider(
          create: (context) =>
              PelajaranBloc(courseRemoteDataSource, widget.email)
                ..add(GetCourseListEvent()),
        ),
      ],
      child: SafeArea(
        right: false,
        left: false,
        bottom: false,
        top: false,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            extendBodyBehindAppBar: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(8 * SizeConfig.heightMultiplier),
              child: AppBar(
                // shape: const RoundedRectangleBorder(
                //   borderRadius: BorderRadius.vertical(
                //     bottom: Radius.circular(15),
                //   ),
                // ),
                shadowColor: Colors.grey.shade200,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent, // <-- SEE HERE
                  statusBarIconBrightness:
                      Brightness.light, //<-- For Android SEE HERE (dark icons)
                  statusBarBrightness:
                      Brightness.light, //<-- For iOS SEE HERE (dark icons)
                ),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: const Color(0xFFF0F3F5),
                centerTitle: false,
                title: appBarContent(),
              ),
            ),
            backgroundColor: const Color(0xFFF0F3F5),
            body: Container(
              alignment: Alignment.topCenter,
              color: const Color(0xFFF0F3F5),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: singleChildScrollView(
                      Column(
                        children: [
                          headline(),
                          //choosePelajaran(),
                          //courseResponseListView(),

                          //bannerResponseListView(),
                          courseResponseListViewBloc(),
                          bannerResponseListViewBloc(),
                        ],
                      ),
                      0,
                      20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget courseResponseListViewBloc() {
    return BlocBuilder<PelajaranBloc, PelajaranState>(
      builder: (context, state) {
        // print(state.runtimeType);
        if (state is PelajaranFailed) {
          return Center(
            child: Text(state.message.toString()),
          );
        } else if (state is PelajaranSuccess) {
          return courseResponseListViewTest(state.pelajaranResponse);
        }

        return Container(
          width: 90 * SizeConfig.imageSizeMultiplier,
          margin: EdgeInsets.only(
            top: 5 * SizeConfig.imageSizeMultiplier,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 2 * SizeConfig.imageSizeMultiplier,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pilih Pelajaran",
                      style: TextStyleSemiBoldLight(
                        size: 1.85 * SizeConfig.textMultiplier,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Routes().semuaPelajaranRoute();
                      },
                      child: Text(
                        "Lihat Semua",
                        style: TextStyleRegullarLight(
                          size: 1.5 * SizeConfig.textMultiplier,
                          color: const Color(0xFF3A7FD5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 80 * SizeConfig.imageSizeMultiplier,
                width: 90 * SizeConfig.imageSizeMultiplier,
                child: const CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget courseResponseListViewTest(CourseResponse res) {
    return Container(
      width: 90 * SizeConfig.imageSizeMultiplier,
      margin: EdgeInsets.only(
        top: 5 * SizeConfig.imageSizeMultiplier,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 2 * SizeConfig.imageSizeMultiplier,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pilih Pelajaran",
                  style: TextStyleSemiBoldLight(
                    size: 1.85 * SizeConfig.textMultiplier,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Routes().semuaPelajaranRoute(
                      widget.email,
                      widget.nama,
                    );
                  },
                  child: Text(
                    "Lihat Semua",
                    style: TextStyleRegullarLight(
                      size: 1.5 * SizeConfig.textMultiplier,
                      color: const Color(0xFF3A7FD5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80 * SizeConfig.imageSizeMultiplier,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // itemCount: courseResponse?.data?.length,
              itemCount: 3,
              itemBuilder: (context, index) {
                final course = res.data?[index];

                //debugPrint(course!.urlCover.toString());
                return PelajaranComponentFetch(
                  title: course!.courseName!,
                  image: course.urlCover.toString(),
                  jumlahMateri: course.jumlahMateri!,
                  jumlahDone: course.jumlahDone!,
                  progress: course.progress!,
                  from: "MAIN-MENU",
                  courseId: course.courseId.toString(),
                  email: widget.email,
                  nama: widget.nama,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerResponseListViewBloc() {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        // print(state.runtimeType);
        if (state is BannerFailed) {
          return Center(
            child: Text(state.message.toString()),
          );
        } else if (state is BannerSuccess) {
          return bannerResponseListViewTest(state.bannerResponse);
        }

        return Container(
          width: 90 * SizeConfig.imageSizeMultiplier,
          margin: EdgeInsets.only(
            top: 0 * SizeConfig.imageSizeMultiplier,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 2 * SizeConfig.imageSizeMultiplier,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Terbaru",
                      style: TextStyleSemiBoldLight(
                        size: 1.85 * SizeConfig.textMultiplier,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 40 * SizeConfig.imageSizeMultiplier,
                width: 90 * SizeConfig.imageSizeMultiplier,
                child: const CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bannerResponseListViewTest(BannerResponse res) {
    return Container(
      width: 90 * SizeConfig.imageSizeMultiplier,
      margin: EdgeInsets.only(
        top: 0 * SizeConfig.imageSizeMultiplier,
        bottom: 20 * SizeConfig.imageSizeMultiplier,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 2 * SizeConfig.imageSizeMultiplier,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Terbaru",
                  style: TextStyleSemiBoldLight(
                    size: 1.85 * SizeConfig.textMultiplier,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40 * SizeConfig.imageSizeMultiplier,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: res.data?.length,
              itemBuilder: (context, index) {
                final banner = res.data?[index];
                return CachedNetworkImage(
                  imageUrl: banner!.eventImage.toString(),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                        left: 0 * SizeConfig.imageSizeMultiplier,
                        right: 4 * SizeConfig.imageSizeMultiplier,
                      ),
                      width: 80 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: 0 * SizeConfig.imageSizeMultiplier,
                        right: 4 * SizeConfig.imageSizeMultiplier,
                      ),
                      width: 80 * SizeConfig.imageSizeMultiplier,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: const CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
                // return Container(
                //   alignment: Alignment.topCenter,
                //   margin: EdgeInsets.only(
                //     left: 0 * SizeConfig.imageSizeMultiplier,
                //     right: 4 * SizeConfig.imageSizeMultiplier,
                //   ),
                //   width: 80 * SizeConfig.imageSizeMultiplier,
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(12),
                //     ),
                //     // image: DecorationImage(
                //     //   image: NetworkImage(banner!.eventImage.toString()),
                //     //   fit: BoxFit.cover,
                //     // ),
                //   ),

                // );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerResponseListView() {
    return (bannerResponse == null)
        ? Container(
            width: 90 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              top: 0 * SizeConfig.imageSizeMultiplier,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 2 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Terbaru",
                        style: TextStyleSemiBoldLight(
                          size: 1.85 * SizeConfig.textMultiplier,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40 * SizeConfig.imageSizeMultiplier,
                  width: 90 * SizeConfig.imageSizeMultiplier,
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
          )
        : Container(
            width: 90 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              top: 0 * SizeConfig.imageSizeMultiplier,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 2 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Terbaru",
                        style: TextStyleSemiBoldLight(
                          size: 1.85 * SizeConfig.textMultiplier,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40 * SizeConfig.imageSizeMultiplier,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: bannerResponse?.data?.length,
                    itemBuilder: (context, index) {
                      final banner = bannerResponse?.data?[index];
                      return CachedNetworkImage(
                        imageUrl: banner!.eventImage.toString(),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(
                              left: 0 * SizeConfig.imageSizeMultiplier,
                              right: 4 * SizeConfig.imageSizeMultiplier,
                            ),
                            width: 80 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              left: 0 * SizeConfig.imageSizeMultiplier,
                              right: 4 * SizeConfig.imageSizeMultiplier,
                            ),
                            width: 80 * SizeConfig.imageSizeMultiplier,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: const CircularProgressIndicator(),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                      // return Container(
                      //   alignment: Alignment.topCenter,
                      //   margin: EdgeInsets.only(
                      //     left: 0 * SizeConfig.imageSizeMultiplier,
                      //     right: 4 * SizeConfig.imageSizeMultiplier,
                      //   ),
                      //   width: 80 * SizeConfig.imageSizeMultiplier,
                      //   decoration: BoxDecoration(
                      //     borderRadius: const BorderRadius.all(
                      //       Radius.circular(12),
                      //     ),
                      //     // image: DecorationImage(
                      //     //   image: NetworkImage(banner!.eventImage.toString()),
                      //     //   fit: BoxFit.cover,
                      //     // ),
                      //   ),

                      // );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget courseResponseListView() {
    return (courseResponse == null)
        ? Container(
            width: 90 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              top: 5 * SizeConfig.imageSizeMultiplier,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 2 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pilih Pelajaran",
                        style: TextStyleSemiBoldLight(
                          size: 1.85 * SizeConfig.textMultiplier,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Routes().semuaPelajaranRoute();
                        },
                        child: Text(
                          "Lihat Semua",
                          style: TextStyleRegullarLight(
                            size: 1.5 * SizeConfig.textMultiplier,
                            color: const Color(0xFF3A7FD5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 80 * SizeConfig.imageSizeMultiplier,
                  width: 90 * SizeConfig.imageSizeMultiplier,
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
          )
        : Container(
            width: 90 * SizeConfig.imageSizeMultiplier,
            margin: EdgeInsets.only(
              top: 5 * SizeConfig.imageSizeMultiplier,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 2 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pilih Pelajaran",
                        style: TextStyleSemiBoldLight(
                          size: 1.85 * SizeConfig.textMultiplier,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Routes().semuaPelajaranRoute(
                            widget.email,
                            widget.nama,
                          );
                        },
                        child: Text(
                          "Lihat Semua",
                          style: TextStyleRegullarLight(
                            size: 1.5 * SizeConfig.textMultiplier,
                            color: const Color(0xFF3A7FD5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80 * SizeConfig.imageSizeMultiplier,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // itemCount: courseResponse?.data?.length,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final course = courseResponse?.data?[index];
                      // return Container(
                      //   alignment: Alignment.topCenter,
                      //   margin: EdgeInsets.only(
                      //     left: 0 * SizeConfig.imageSizeMultiplier,
                      //     right: 4 * SizeConfig.imageSizeMultiplier,
                      //   ),
                      //   width: 80 * SizeConfig.imageSizeMultiplier,
                      //   decoration: BoxDecoration(
                      //     borderRadius: const BorderRadius.all(
                      //       Radius.circular(12),
                      //     ),
                      //     image: DecorationImage(
                      //       image: NetworkImage(banner!.urlCover.toString()),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // );
                      //debugPrint(course!.urlCover.toString());
                      return PelajaranComponentFetch(
                        title: course!.majorName!,
                        image: course.urlCover.toString(),
                        jumlahMateri: course.jumlahMateri!,
                        jumlahDone: course.jumlahDone!,
                        progress: course.progress!,
                        from: "MAIN-MENU",
                        courseId: course.courseId.toString(),
                        email: widget.email,
                        nama: widget.nama,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget appBarContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hai ${widget.nama}",
              style: TextStyleSemiBoldLight(
                size: 1.75 * SizeConfig.textMultiplier,
                color: Colors.black,
              ),
            ),
            Text(
              "Selamat Datang",
              style: TextStyleRegullarLight(
                size: 1.45 * SizeConfig.textMultiplier,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Container(
          height: 10 * SizeConfig.imageSizeMultiplier,
          width: 10 * SizeConfig.imageSizeMultiplier,
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
    );
  }

  Widget headline() {
    return Container(
      height: 38 * SizeConfig.imageSizeMultiplier,
      width: 90 * SizeConfig.imageSizeMultiplier,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xFF3A7FD5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 8 * SizeConfig.imageSizeMultiplier,
                  left: 4 * SizeConfig.imageSizeMultiplier,
                ),
                width: 30 * SizeConfig.imageSizeMultiplier,
                child: Text(
                  "Mau Kerjain Latihan Soal Apa Hari Ini ?",
                  style: TextStyleSemiBoldLight(
                    size: 1.85 * SizeConfig.textMultiplier,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 25 * SizeConfig.imageSizeMultiplier,
                width: 45 * SizeConfig.imageSizeMultiplier,
                margin: EdgeInsets.only(
                  top: 13 * SizeConfig.imageSizeMultiplier,
                  right: 1 * SizeConfig.imageSizeMultiplier,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.headline),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget choosePelajaran() {
    return Container(
      width: 90 * SizeConfig.imageSizeMultiplier,
      margin: EdgeInsets.only(
        top: 5 * SizeConfig.imageSizeMultiplier,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 1 * SizeConfig.imageSizeMultiplier,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pilih Pelajaran",
                  style: TextStyleSemiBoldLight(
                    size: 1.85 * SizeConfig.textMultiplier,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Routes().semuaPelajaranRoute(
                      widget.email,
                      widget.nama,
                    );
                  },
                  child: Text(
                    "Lihat Semua",
                    style: TextStyleRegullarLight(
                      size: 1.5 * SizeConfig.textMultiplier,
                      color: const Color(0xFF3A7FD5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const PelajaranComponent(title: "Matematika", image: Images.mtk),
          // const PelajaranComponent(title: "Fisika", image: Images.fisika),
          // const PelajaranComponent(title: "Kimia", image: Images.kimia),
        ],
      ),
    );
  }

  // Widget iklan() {
  //   return Container(
  //     width: 90 * SizeConfig.imageSizeMultiplier,
  //     margin: EdgeInsets.only(
  //       top: 5 * SizeConfig.imageSizeMultiplier,
  //     ),
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(
  //             bottom: 2 * SizeConfig.imageSizeMultiplier,
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Terbaru",
  //                 style: TextStyleSemiBoldLight(
  //                   size: 1.85 * SizeConfig.textMultiplier,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         carouselExample(),
  //       ],
  //     ),
  //   );
  // }

  // Widget carouselExample() {
  //   return Container(
  //     margin: EdgeInsets.only(
  //       // bottom: 10 * SizeConfig.imageSizeMultiplier,
  //       top: 0 * SizeConfig.imageSizeMultiplier,
  //     ),
  //     child: Column(
  //       children: [
  //         CarouselSlider(
  //           items: [
  //             Container(
  //               alignment: Alignment.center,
  //               // height: 9 * SizeConfig.imageSizeMultiplier,
  //               width: 100 * SizeConfig.imageSizeMultiplier,
  //               decoration: const BoxDecoration(
  //                 image: DecorationImage(
  //                   image: AssetImage(Images.iklan1),
  //                   fit: BoxFit.contain,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               alignment: Alignment.center,
  //               // height: 9 * SizeConfig.imageSizeMultiplier,
  //               width: 100 * SizeConfig.imageSizeMultiplier,
  //               decoration: const BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(10)),
  //                 color: Colors.amber,
  //               ),
  //             ),
  //           ],
  //           options: CarouselOptions(
  //             // pageSnapping: false,
  //             // height: 180.0,
  //             // height: MediaQuery.of(context).size.height,
  //             height: 40 * SizeConfig.imageSizeMultiplier,
  //             enlargeCenterPage: false,
  //             autoPlay: false,
  //             enlargeFactor: 0.2,
  //             aspectRatio: 16 / 9,
  //             autoPlayCurve: Curves.fastOutSlowIn,
  //             enableInfiniteScroll: true,
  //             autoPlayAnimationDuration: const Duration(milliseconds: 800),
  //             viewportFraction: 0.95,
  //             // onPageChanged: (val, _) {
  //             //   setState(() {
  //             //     print("new index $val");
  //             //     controller.jumpToPage(val);
  //             //   });
  //             // },
  //             onPageChanged: (index, reason) {
  //               // setState(() {
  //               //   currentPos = index;
  //               // });
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
