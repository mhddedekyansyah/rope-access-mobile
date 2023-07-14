import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/jasa_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/custom_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailJasa extends StatefulWidget {
  final JasaModel jasaModel;
  const DetailJasa({super.key, required this.jasaModel});

  @override
  State<DetailJasa> createState() => _DetailJasaState();
}

class _DetailJasaState extends State<DetailJasa> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: AppColors.background3,
      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                          items: widget.jasaModel.galleries != null &&
                                  widget.jasaModel.galleries!.isNotEmpty
                              ? (widget.jasaModel.galleries as List<dynamic>)
                                  .map((gallery) => Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${ApiConstant.publicUrl}${gallery.image}'),
                                              fit: BoxFit.cover),
                                        ),
                                      ))
                                  .toList()
                              : [],
                          options: CarouselOptions(
                            height: height * .5,
                            initialPage: currentIndex,
                            onPageChanged: (index, reason) {
                              setState(
                                () {
                                  currentIndex = index;
                                },
                              );
                            },
                            autoPlay: widget.jasaModel.galleries!.length < 2
                                ? false
                                : true,
                            viewportFraction: 1,
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () => context.pop(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama Jasa',
                                    style: AppTextStyle.primaryStyle.copyWith(
                                      fontWeight: AppFontWeight.semibold,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.jasaModel.name.toString(),
                                    style: AppTextStyle.secondaryStyle,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deskripsi',
                                    style: AppTextStyle.primaryStyle.copyWith(
                                      fontWeight: AppFontWeight.semibold,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.jasaModel.description ?? 'Deskripsi',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Harga',
                                    style: AppTextStyle.primaryStyle.copyWith(
                                      fontWeight: AppFontWeight.semibold,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    priceFormat(
                                        number:
                                            int.parse(widget.jasaModel.price!),
                                        locale: 'id',
                                        decimalDigit: 0,
                                        symbol: 'IDR '),
                                    style: AppTextStyle.priceStyle,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: CustomBtn(
                    text: 'Booking Jasa',
                    onPressed: () async {
                      if (Platform.isAndroid) {
                        String text =
                            'konfirmasi pembayaran booking jasa ${widget.jasaModel.name} senilai ${priceFormat(number: int.parse(widget.jasaModel.price!), locale: 'id', decimalDigit: 0, symbol: 'IDR ')}';
                        var wa =
                            "whatsapp://send?phone=6285372235517&text=$text";
                        await launchUrl(Uri.parse(wa));
                      }
                      // bool whatsapp =
                      //     await FlutterLaunch.hasApp(name: "whatsapp");

                      // if (whatsapp) {
                      //   await FlutterLaunch.launchWhatsapp(
                      //       phone: "5534992016100",
                      //       message: "Hello, flutter_launch");
                      // } else {
                      //   showCustomSnackbar(context, 'whatsapp no installed');
                      // }
                    })),
          )
        ],
      ),
    );
  }
}
