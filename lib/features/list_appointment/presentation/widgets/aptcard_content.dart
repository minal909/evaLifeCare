import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CardContents extends StatelessWidget {
  String date;
  String time;
  String drname;
  String service;

  CardContents(
      {required this.date,
      required this.time,
      required this.drname,
      required this.service,
      super.key});

  @override
  Widget build(BuildContext context) {
    var screenOrientation1 = MediaQuery.orientationOf(context);
    Size deviceSize = MediaQuery.of(context).size;
    Widget textWidget(String text, FontWeight fw) => Text(
          text,
          style: screenOrientation1.toString() == "Orientation.portrait" &&
                  deviceSize.height > 650
              ? TextStyle(fontSize: deviceSize.width * 0.028, fontWeight: fw)
              : screenOrientation1.toString() == "Orientation.landscape"
                  ? TextStyle(
                      fontSize: deviceSize.width * 0.016, fontWeight: fw)
                  : TextStyle(
                      fontSize: deviceSize.width * 0.037, fontWeight: fw),
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(),
          child: SizedBox(
            width: deviceSize.width * 0.29,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenOrientation1.toString() ==
                              "Orientation.landscape"
                          ? deviceSize.height * 0.018
                          : deviceSize.height * 0.01),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/calendar.svg',
                        semanticsLabel: 'My SVG Image',
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: textWidget(date, FontWeight.normal)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/clock.svg',
                      semanticsLabel: 'My SVG Image',
                      height: 16,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: textWidget(time, FontWeight.normal)),
                  ],
                ),
              ],
            ),
          ),
        ),
        // const Expanded(
        //     child:
        const Flexible(
          fit: FlexFit.tight,
          child: SizedBox(
            width: 1,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(right: deviceSize.width * 0.055),
          child: SizedBox(
            width: deviceSize.width * 0.45,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenOrientation1.toString() ==
                              "Orientation.landscape"
                          ? deviceSize.height * 0.018
                          : deviceSize.height * 0.01),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/doctor 1.svg',
                        semanticsLabel: 'My SVG Image',
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: textWidget(drname, FontWeight.normal)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/stethoscope (1).svg',
                      semanticsLabel: 'My SVG Image',
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: textWidget(service, FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
