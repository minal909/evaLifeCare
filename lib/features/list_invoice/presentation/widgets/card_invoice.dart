import 'package:eva_life_care/features/list_invoice/presentation/widgets/invoicecard_actionbuttons.dart';
import 'package:eva_life_care/features/list_invoice/presentation/widgets/invoicecard_content.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardInvoice extends StatelessWidget {
  String invUrl;
  int invcid;
  int patientid;

  int aptid;
  String name;
  String? status;
  String date;
  double? orderTotal;
  double? tax;
  double? discount;
  CardInvoice(
      {required this.invUrl,
      required this.invcid,
      required this.patientid,
      required this.aptid,
      required this.name,
      required this.status,
      required this.date,
      required this.orderTotal,
      required this.tax,
      required this.discount,
      super.key});

  List aptResult = [];
  @override
  Widget build(BuildContext context) {
    var screenOrientation1 = MediaQuery.orientationOf(context);
    Size deviceSize = MediaQuery.of(context).size;
    Widget textWidget(String text, FontWeight fw) => Text(
          text,
          style: screenOrientation1.toString() == "Orientation.portrait" &&
                  deviceSize.height > 650
              ? TextStyle(fontSize: deviceSize.width * 0.024, fontWeight: fw)
              : screenOrientation1.toString() == "Orientation.landscape"
                  ? TextStyle(
                      fontSize: deviceSize.width * 0.016, fontWeight: fw)
                  : TextStyle(
                      fontSize: deviceSize.width * 0.031, fontWeight: fw),
        );

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(9))),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: screenOrientation1.toString() ==
                              "Orientation.landscape"
                          ? deviceSize.width * 0.055
                          : deviceSize.width * 0.08,
                      height: screenOrientation1.toString() ==
                              "Orientation.landscape"
                          ? deviceSize.height * 0.11
                          : deviceSize.height * 0.06,
                      decoration: const BoxDecoration(
                          color: Color(0xfffba03b),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(9),
                              bottomRight: Radius.circular(9))),
                      child: Center(
                          child: Text(
                        invcid.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Text(
                      name,
                      style: screenOrientation1.toString() ==
                                  "Orientation.portrait" &&
                              deviceSize.height > 650
                          ? TextStyle(
                              fontSize: deviceSize.width * 0.03,
                              fontWeight: FontWeight.bold)
                          : screenOrientation1.toString() ==
                                  "Orientation.landscape"
                              ? TextStyle(
                                  fontSize: deviceSize.width * 0.018,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: deviceSize.width * 0.033,
                                  fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(
                      width: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenOrientation1.toString() ==
                                "Orientation.landscape"
                            ? deviceSize.height * 0.018
                            : deviceSize.height * 0.003),
                    child: Container(
                      // width: screenOrientation1.toString() ==
                      //         "Orientation.landscape"
                      //     ? deviceSize.width * 0.085
                      //     : status == 'Cancelled'
                      //         ? deviceSize.width * 0.15
                      //         : deviceSize.width * 0.085,
                      decoration: BoxDecoration(
                          color: status == 'Paid'
                              ? Colors.green
                              : status == 'Due'
                                  ? const Color.fromARGB(255, 12, 133, 149)
                                  : const Color.fromARGB(255, 210, 52, 4),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      child: Padding(
                        padding: const EdgeInsets.all(4.5),
                        child: Text(
                          status.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenOrientation1.toString() ==
                                    "Orientation.landscape"
                                ? deviceSize.width * 0.015
                                : deviceSize.width * 0.023,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenOrientation1.toString() ==
                                "Orientation.landscape"
                            ? deviceSize.width * 0.015
                            : deviceSize.width * 0.012,
                        left: deviceSize.width * 0.015),
                    child: ActionButtonInvoice(invUrl),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: screenOrientation1.toString() ==
                              "Orientation.landscape"
                          ? deviceSize.width * 0.069
                          : deviceSize.width * 0.1,
                      top: 4,
                      bottom: 10),
                  child: CardContentsInvoice(
                    date: date,
                    ordertotal: orderTotal.toString(),
                    tax: tax.toString(),
                    discount: discount.toString(),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
