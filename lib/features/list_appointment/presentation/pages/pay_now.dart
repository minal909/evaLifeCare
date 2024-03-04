// ignore_for_file: use_build_context_synchronously

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/order_total_entity.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/payinvoice_entity.dart';
import 'package:eva_life_care/features/list_appointment/data/datasources/payInvoice_remote_datasource.dart';
import 'package:eva_life_care/features/list_appointment/presentation/pages/list_appointment_page.dart';
import 'package:eva_life_care/features/list_appointment/presentation/providers/orderTotal_provider.dart';
import 'package:eva_life_care/features/list_appointment/presentation/providers/pay_invoice_provider.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/login_page.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PayNow extends StatefulWidget {
  int aptid;
  int pId;
  String billAddress;
  String mobile;
  double? orderSubtotal;
  OrderTotalEntity? getTotal;

  PayNow(this.aptid, this.pId, this.billAddress, this.mobile,
      this.orderSubtotal, this.getTotal,
      {super.key});

  @override
  State<PayNow> createState() =>
      // ignore: no_logic_in_create_state
      _PayNowState(aptid, pId, billAddress, mobile, orderSubtotal, getTotal);
}

class _PayNowState extends State<PayNow> {
  int aptid;
  int pId;
  String billAddress;
  String mobile;
  double? orderSubtotal;
  OrderTotalEntity? getTotal;

  _PayNowState(this.aptid, this.pId, this.billAddress, this.mobile,
      this.orderSubtotal, this.getTotal);

  TextEditingController serviceCharge = TextEditingController();
  bool light = false;
  String _singleValue = "";
  TextEditingController discValue = TextEditingController();
  SizedBox sizedbox = const SizedBox(
    width: 15,
  );
  TextEditingController description = TextEditingController();
  TextEditingController balanceAmt = TextEditingController();
  OrderTotalEntity? getDiscTotal;
  PayInvoiceEntity? payinvoiceEntity;

  bool discApplied = false;

  applyDiscount(BuildContext context) async {
    WidgetHelper.startLoading('');
    await Provider.of<OrderTotalProvider>(context, listen: false)
        .eitherFailureOrOrderTotal(
            orderSubtotal: orderSubtotal,
            discountApplication: [
          {
            "type": "manual",
            "value_type": _singleValue,
            "coupon_discount": {"id": "", "code": ""},
            "manual_discount": {
              "value": double.parse(discValue.text),
              "description": description.text
            }
          }
        ]);
    setState(() {
      getDiscTotal =
          Provider.of<OrderTotalProvider>(context, listen: false).orderTotal;
      discApplied = true;
    });
    WidgetHelper.endLoading();
  }

  payInvoice(BuildContext context) async {
    await Provider.of<PayInvoiceProvider>(context, listen: false)
        .eitherFailureOrPayInvoice(
            aptid: aptid,
            clientid: clientID,
            brancid: branchID,
            patientid: pId,
            datetimegenerated: DateTime.now().toUtc().toString(),
            datetimedue: DateTime.now().toUtc().toString(),
            datetimeupdated: DateTime.now().toUtc().toString(),
            billingaddress: billAddress,
            mobile: mobile,
            orderSubtotal: orderSubtotal,
            taxrate:
                discApplied
                    ? getDiscTotal!.result.taxRate
                    : getTotal!.result.taxRate,
            taxamount: discApplied
                ? getDiscTotal!.result.taxAmount
                : getTotal!.result.taxAmount,
            ordertotal: discApplied
                ? getDiscTotal!.result.orderTotal
                : getTotal!.result.orderTotal,
            discAmount: discApplied
                ? getDiscTotal!.result.discountAmount
                : getTotal!.result.discountAmount,
            discountApplication: [
          discApplied
              ? {
                  "type": "manual",
                  "value_type": _singleValue,
                  "coupon_discount": {"id": "", "code": ""},
                  "manual_discount": {
                    "value": double.parse(discValue.text),
                    "description": description.text
                  }
                }
              : {}
        ]);
    setState(() {
      payinvoiceEntity =
          Provider.of<PayInvoiceProvider>(context, listen: false).payInvoice;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size devicesize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white, // Set background color
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Form(
          // height: MediaQuery.of(context).size.height * 0.65,
          child: Padding(
            padding: EdgeInsets.only(
                left: devicesize.width * 0.07,
                top: devicesize.height * 0.03,
                bottom: devicesize.height * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Order subtotal            ',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text('${getTotal!.result.orderSubtotal}')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Apply Discount          ',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        // This bool value toggles the switch.
                        value: light,
                        activeColor: Theme.of(context).colorScheme.onPrimary,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            light = value;
                            light == false ? _singleValue = "" : null;
                            light == false ? discApplied = false : null;
                            light == false ? discValue.text = '' : null;
                          });
                        },
                      ),
                    )
                  ],
                ),
                if (light) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Discount Type         ',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: RadioButton(
                          description: "Fixed",

                          value: "fixed",
                          groupValue: _singleValue,
                          fillColor: Theme.of(context).colorScheme.onPrimary,

                          onChanged: (value) {
                            setState(
                              () => _singleValue = value ?? '',
                            );
                            print('selected val ----------$_singleValue');
                          },
                          // activeColor: Colors.red,
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: RadioButton(
                          description: "Percentage",
                          value: "percentage",
                          groupValue: _singleValue,
                          fillColor: Theme.of(context).colorScheme.onPrimary,

                          onChanged: (value) {
                            setState(
                              () => _singleValue = value ?? '',
                            );
                            print('selected val ----------$_singleValue');
                          },
                          // activeColor: Colors.red,
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),

                      //   ],
                      // ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Discount Value            ',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: screenOrientation.toString() ==
                                "Orientation.portrait"
                            ? MediaQuery.of(context).size.height * 0.05
                            : MediaQuery.of(context).size.height * 0.06,
                        width: screenOrientation.toString() ==
                                "Orientation.portrait"
                            ? MediaQuery.of(context).size.width * 0.26
                            : MediaQuery.of(context).size.width * 0.2,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodySmall,
                          readOnly: _singleValue == "" ? true : false,
                          onTap: () {
                            _singleValue == ""
                                ? Fluttertoast.showToast(
                                    msg: "Please select discount type !",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                  )
                                : null;
                          },
                          keyboardType: TextInputType.number,
                          controller: discValue,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                            labelText: '',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      SizedBox(
                        width: devicesize.width * 0.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: discValue.text.isNotEmpty
                                ? const Color(0xFFFCA03C)
                                : Colors.grey,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            _singleValue == "" ||
                                    discValue.text == '' ||
                                    discValue.text == '0'
                                ? Fluttertoast.showToast(
                                    msg: "Please enter valid discount value !",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                  )
                                : applyDiscount(context);
                          },
                          child: Text('Apply',
                              style: TextStyle(
                                  fontSize: devicesize.width * 0.03,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      // Card(
                      //   elevation: 6,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius: const BorderRadius.only(
                      //           topLeft: Radius.circular(10),
                      //           topRight: Radius.circular(10),
                      //           bottomLeft: Radius.circular(10),
                      //           bottomRight: Radius.circular(10),
                      //         ),
                      //         gradient: LinearGradient(
                      //             begin: Alignment.topCenter,
                      //             end: Alignment.bottomCenter,
                      //             colors: [
                      //               discValue.text.isEmpty
                      //                   ? const Color.fromARGB(
                      //                       255, 193, 193, 193)
                      //                   : const Color.fromARGB(
                      //                       255, 54, 232, 205),
                      //               discValue.text.isEmpty
                      //                   ? Colors.grey
                      //                   : const Color.fromARGB(
                      //                       255, 3, 146, 124),
                      //             ])),
                      //     width: screenOrientation.toString() ==
                      //             "Orientation.portrait"
                      //         ? MediaQuery.of(context).size.width * 0.2
                      //         : MediaQuery.of(context).size.width * 0.13,
                      //     height: screenOrientation.toString() ==
                      //             "Orientation.portrait"
                      //         ? MediaQuery.of(context).size.height * 0.045
                      //         : MediaQuery.of(context).size.height * 0.07,
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         _singleValue == "" || discValue.text == ''
                      //             ? Fluttertoast.showToast(
                      //                 msg:
                      //                     "Discount type/value required to apply discount !",
                      //                 toastLength: Toast.LENGTH_LONG,
                      //                 gravity: ToastGravity.CENTER,
                      //                 timeInSecForIosWeb: 1,
                      //               )
                      //             : applyDiscount(context);
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.transparent,
                      //           shadowColor: Colors.transparent),
                      //       child: Text(
                      //         'Apply',
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.white,
                      //             fontSize: screenOrientation.toString() ==
                      //                     "Orientation.portrait"
                      //                 ? MediaQuery.of(context).size.width *
                      //                     0.03
                      //                 : MediaQuery.of(context).size.width *
                      //                     0.018),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: devicesize.height * 0.025,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Column(
                        children: [
                          Text(
                            'Description                 ',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '(Optional)                    ',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: SizedBox(
                          height: screenOrientation.toString() ==
                                  "Orientation.portrait"
                              ? MediaQuery.of(context).size.height * 0.05
                              : MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller: description,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                              labelText: '',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: devicesize.height * 0.028,
                  ),
                  discApplied == false
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Discount applied          ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 89, 168, 92)),
                            ),
                            Text(
                              getDiscTotal!.result.discountAmount
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 89, 168, 92)),
                            )
                          ],
                        ),
                ],
                discApplied == false
                    ? const SizedBox()
                    : SizedBox(
                        height: devicesize.height * 0.028,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Tax Rate                         ',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    discApplied == false
                        ? Text('${getTotal!.result.taxRate}')
                        : Text('${getDiscTotal!.result.taxRate}')
                  ],
                ),
                SizedBox(
                  height: devicesize.height * 0.028,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Tax Amount                   ',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    discApplied == false
                        ? Text('${getTotal!.result.taxAmount}')
                        : Text(
                            getDiscTotal!.result.taxAmount.toStringAsFixed(2))
                  ],
                ),
                SizedBox(
                  height: devicesize.height * 0.028,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Total                     ',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    discApplied == false
                        ? Text(
                            "${getTotal!.result.orderTotal}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        : Text(
                            "${getDiscTotal!.result.orderTotal}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: devicesize.height * 0.06,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: devicesize.width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                // Color.fromARGB(255, 7, 176, 150),
                                Theme.of(context).colorScheme.secondary,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            light = false;
                            discValue.text = '';
                            description.text = '';
                            _singleValue = '';
                          },

                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                          // child: ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.pop(context);
                          //     light = false;
                          //     discValue.text = '';
                          //     description.text = '';
                          //     _singleValue = '';
                          //   },
                          //   style: ButtonStyle(
                          //       backgroundColor:
                          //           MaterialStateProperty.all<Color>(
                          //               Colors.white),
                          //       shape: MaterialStateProperty.all<
                          //               RoundedRectangleBorder>(
                          //           const RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.only(
                          //                 topLeft: Radius.circular(10),
                          //                 topRight: Radius.circular(10),
                          //                 bottomLeft: Radius.circular(10),
                          //                 bottomRight: Radius.circular(10),
                          //               ),
                          //               side: BorderSide(
                          //                 color: Color.fromARGB(
                          //                     255, 46, 47, 47),
                          //               )))),
                          //   child: Text(
                          //     'Cancel',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         color:
                          //             const Color.fromARGB(255, 46, 47, 47),
                          //         fontSize: screenOrientation.toString() ==
                          //                 "Orientation.portrait"
                          //             ? MediaQuery.of(context).size.width *
                          //                 0.03
                          //             : MediaQuery.of(context).size.width *
                          //                 0.019),
                          //   ),
                          // ),
                        ),
                      ),
                      SizedBox(
                        width: devicesize.width * 0.025,
                      ),
                      SizedBox(
                        width: devicesize.width * 0.3,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  // Color.fromARGB(255, 7, 176, 150),
                                  light == true && discApplied == false
                                      ? Colors.grey
                                      : light == true && discApplied == true
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                          : const Color.fromARGB(
                                              255, 3, 146, 124),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            onPressed: () async {
                              bool isConnected =
                                  await NetworkInfoImpl(DataConnectionChecker())
                                      .isConnected;
                              if (!isConnected) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        NoInternet(onPressed: () async {
                                          bool isConnected =
                                              await NetworkInfoImpl(
                                                      DataConnectionChecker())
                                                  .isConnected;
                                          isConnected == false
                                              ? WidgetHelper.endLoading()
                                              : WidgetHelper.endLoading();

                                          if (!isConnected) {
                                            Fluttertoast.showToast(
                                                msg: "No internet connection!",
                                                gravity: ToastGravity.CENTER);
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => PayNow(
                                                        aptid,
                                                        pId,
                                                        billAddress,
                                                        mobile,
                                                        orderSubtotal,
                                                        getTotal)));
                                            // await getData(context);
                                          }
                                        })));

                                // Provider.of<MyAuthProvider>(context, listen: false)
                                //     .signOutCurrentUser();
                                // wschannel.sink.close();
                              } else {
                                light == true && discApplied == false
                                    ? Fluttertoast.showToast(
                                        msg:
                                            "Plesae apply discount to proceed!",
                                        gravity: ToastGravity.CENTER)
                                    : light == true && discApplied == true
                                        ? await payInvoice(context)
                                        : light == false
                                            ? await payInvoice(context)
                                            : null;
                              }
                            },
                            child: const Text(
                              'Pay',
                              style: TextStyle(color: Colors.white),
                            )
                            // gradient: LinearGradient(
                            //     begin: Alignment.topCenter,
                            //     end: Alignment.bottomCenter,
                            //     colors: [
                            //       light == true && discApplied == false
                            //           ? const Color.fromARGB(
                            //               255, 193, 193, 193)
                            //           : light == true &&
                            //                   discApplied == true
                            //               ? const Color.fromARGB(
                            //                   255, 54, 232, 205)
                            //               : const Color.fromARGB(
                            //                   255, 54, 232, 205),
                            //       light == true && discApplied == false
                            //           ? Colors.grey
                            //           : light == true &&
                            //                   discApplied == true
                            //               ? const Color.fromARGB(
                            //                   255, 3, 146, 124)
                            //               : const Color.fromARGB(
                            //                   255, 3, 146, 124),
                            //     ]
                            //     )
                            ),
                        // width: screenOrientation.toString() ==
                        //         "Orientation.portrait"
                        //     ? MediaQuery.of(context).size.width * 0.24
                        //     : MediaQuery.of(context).size.width * 0.17,
                        // height: screenOrientation.toString() ==
                        //         "Orientation.portrait"
                        //     ? MediaQuery.of(context).size.height * 0.048
                        //     : MediaQuery.of(context).size.height * 0.07,
                        // child: ElevatedButton(
                        // onPressed: () async {
                        //   bool isConnected = await NetworkInfoImpl(
                        //           DataConnectionChecker())
                        //       .isConnected;
                        //   if (!isConnected) {
                        //     WidgetHelper.endLoading();
                        //     Navigator.of(context).push(
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 NoInternet(onPressed: () async {
                        //                   bool isConnected =
                        //                       await NetworkInfoImpl(
                        //                               DataConnectionChecker())
                        //                           .isConnected;
                        //                   isConnected == false
                        //                       ? WidgetHelper
                        //                           .endLoading()
                        //                       : null;

                        //                   if (!isConnected) {
                        //                     Fluttertoast.showToast(
                        //                         msg:
                        //                             "No internet connection!",
                        //                         gravity: ToastGravity
                        //                             .CENTER);
                        //                   } else {
                        //                     Navigator.push(
                        //                         context,
                        //                         MaterialPageRoute(
                        //                             builder: (_) =>
                        //                                 PayNow(
                        //                                     aptid,
                        //                                     pId,
                        //                                     billAddress,
                        //                                     mobile,
                        //                                     orderSubtotal,
                        //                                     getTotal)));
                        //                     // await getData(context);
                        //                   }
                        //                 })));

                        //     // Provider.of<MyAuthProvider>(context, listen: false)
                        //     //     .signOutCurrentUser();
                        //     // wschannel.sink.close();
                        //   } else {
                        //     light == true && discApplied == false
                        //         ? Fluttertoast.showToast(
                        //             msg:
                        //                 "Plesae apply discount to proceed!",
                        //             gravity: ToastGravity.CENTER)
                        //         : light == true && discApplied == true
                        //             ? await payInvoice(context)
                        //             : light == false
                        //                 ? await payInvoice(context)
                        //                 : null;
                        //   }
                        // },
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.transparent,
                        //     shadowColor: Colors.transparent),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // SizedBox(width: 400, height: 250, child: Image.asset('assets/images/New Messages.png')),
          ),
        ),
      ),
    );
  }
}
