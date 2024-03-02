// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:eva_life_care/features/book%20appointment/presentation/pages/book_apt_form.dart';
import 'package:eva_life_care/features/list_invoice/data/models/list_invoice_model.dart';
import 'package:eva_life_care/features/list_invoice/presentation/providers/list_invoice_provider.dart';

import 'package:eva_life_care/features/list_invoice/presentation/widgets/card_invoice.dart';
import 'package:eva_life_care/features/skeleton/widgets/app_bar_widget.dart';
import 'package:eva_life_care/features/skeleton/widgets/bottom_app_bar.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/skeleton/widgets/navigation_drawer.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListInvoicePage extends StatefulWidget {
  const ListInvoicePage({super.key});

  @override
  State<ListInvoicePage> createState() => _ListInvoicePageState();
}

class _ListInvoicePageState extends State<ListInvoicePage>
    with WidgetsBindingObserver {
  var currentTime;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    LogInProvider provider = Provider.of<LogInProvider>(context, listen: false);
    provider.fetchService(context);
    provider.fetchId(context);
    fetchData(
      context,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool changed = false;
  @override
  void didChangeMetrics() {
    changed = true;
  }

  List<Result> invoicelist = [];
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  bool isFilter = false;

  fetchData(
    BuildContext context,
  ) async {
    pulledDown || isFilter ? null : WidgetHelper.startLoading('');
    await Provider.of<ListInvoiceProvider>(context, listen: false)
        .eitherFailureOrListInvoice(
            isFilter, pulledDown, name.text, mobile.text);

    var result =
        Provider.of<ListInvoiceProvider>(context, listen: false).listInvoice;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      invoicelist = result!.result;
      prefs.setString('widget', 'listinvoice');
    });

    pulledDown || isFilter ? null : WidgetHelper.endLoading();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool pulledDown = false;

  @override
  Widget build(BuildContext context) {
    void setPage() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('widget', 'listinvoice');
    }

    Size deviceSize = MediaQuery.of(context).size;
    var screenOrientation1 = MediaQuery.orientationOf(context);

    setPage();
    // List<Result> listOfService = [];
    // ListServiceEntity? listservice;

    // List listOfDoctor = [];
    // ListDoctorEntity? listdoctor;

    // List listOfidproof = [];
    // ListIdProofEntity? listidproof;

    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentTime == null ||
            now.difference(currentTime) > const Duration(seconds: 2)) {
          //add duration of press gap
          currentTime = now;
          Fluttertoast.showToast(msg: "Press back again to exit");

          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text('Press back again to exit')));
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          exit(0);
        }
      },
      child: Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: MyAppbar(
          widget: const ListInvoicePage(),
        ),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: const BottomAppWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BookAppointment(
                          const ListInvoicePage(),
                          listOfService,
                          listOfidproof,
                          serviceList,
                          "listinvoice")));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => BookAppointment(
              //             listOfService, listOfidproof, listOfidproof)));
            },
            tooltip: 'Book Appointment',
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xffd8e7e8),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  deviceSize.height * 0.005 * deviceSize.width * 0.005,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invoice List',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenOrientation1.toString() ==
                                    "Orientation.portrait" &&
                                deviceSize.height > 650
                            ? deviceSize.width * 0.029
                            : screenOrientation1.toString() ==
                                    "Orientation.landscape"
                                ? deviceSize.width * 0.021
                                : deviceSize.width * 0.04,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        name.clear();
                        mobile.clear();

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: SizedBox(
                                  height: screenOrientation1.toString() ==
                                          "Orientation.portrait"
                                      ? MediaQuery.of(context).size.height *
                                          0.35
                                      : MediaQuery.of(context).size.height *
                                          0.5,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 37, right: 37),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.filter_alt_outlined,
                                                size: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                              Text(
                                                'Filters',
                                                style: TextStyle(
                                                  fontSize: screenOrientation1
                                                              .toString() ==
                                                          "Orientation.landscape"
                                                      ? deviceSize.width * 0.019
                                                      : deviceSize.width * 0.03,
                                                ),
                                              ),
                                              const Flexible(
                                                fit: FlexFit.tight,
                                                child: SizedBox(
                                                  width: 1,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceSize.height * 0.025,
                                              right: deviceSize.width * 0.008),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6))),
                                            height:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.045
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.07,
                                            width:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.8
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.5,
                                            child: TextFormField(
                                              textAlign: TextAlign.start,
                                              controller: name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              onChanged: (value) async {
                                                // searchdoc;
                                                name.text = value;
                                              },
                                              // maxLines: 2,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                labelText: 'Patient Name',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: deviceSize.height * 0.015),
                                        // sizedbox,
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: deviceSize.width * 0.008),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6))),
                                            height:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.045
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.07,
                                            width:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.8
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.5,
                                            child: TextFormField(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,

                                              keyboardType:
                                                  TextInputType.number,
                                              controller: mobile,
                                              // maxLines: 2,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                labelText: 'Mobile',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6))),
                                              ),
                                              onChanged: (value) async {
                                                // searchdoc;
                                                mobile.text = value;
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: deviceSize.height * 0.015),

                                        // sizedbox,
                                        // GestureDetector(
                                        //   onTap: () async {},
                                        //   child:
                                        Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 54, 232, 205),
                                                    Color.fromARGB(
                                                        255, 3, 146, 124),
                                                  ])),
                                          height:
                                              screenOrientation1.toString() ==
                                                      "Orientation.portrait"
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                          width:
                                              screenOrientation1.toString() ==
                                                      "Orientation.portrait"
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              isFilter = true;
                                              changed = true;
                                              await fetchData(context);

                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor:
                                                    Colors.transparent),
                                            child: Text(
                                              'Apply',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: screenOrientation1
                                                              .toString() ==
                                                          "Orientation.portrait"
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.018),
                                            ),
                                          ),
                                        ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: deviceSize.width * 0.01,
                            ),
                            child: Icon(
                              Icons.filter_alt_rounded,
                              size: 15,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Filters',
                            style: TextStyle(
                              fontSize: screenOrientation1.toString() ==
                                      "Orientation.landscape"
                                  ? deviceSize.width * 0.019
                                  : deviceSize.width * 0.03,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              isFilter && invoicelist.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(left: deviceSize.width * 0.35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "-----Filter results------",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: screenOrientation1.toString() ==
                                        'Orientation.portrait'
                                    ? deviceSize.width * 0.03
                                    : deviceSize.width * 0.02),
                          ),
                          const Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox(
                              width: 1,
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                name.clear();
                                mobile.clear();
                                isFilter = false;
                                pulledDown = true;

                                await fetchData(context);
                              },
                              child: const Text('clear filters'))
                        ],
                      ),
                    )
                  : isFilter && invoicelist.isEmpty
                      ? const Text("No invoices found")
                      : const SizedBox(),
              Expanded(
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  color: Colors.white,
                  strokeWidth: 2.0,
                  backgroundColor: const Color.fromARGB(137, 23, 22, 22),
                  onRefresh: () async {
                    name.clear();
                    mobile.clear();
                    isFilter = false;
                    pulledDown = true;

                    await fetchData(context);
                    // Replace this delay with the code to be executed during refresh
                    // and return a Future when code finishes execution.
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  child: ListView.builder(
                    itemCount: invoicelist.length,
                    itemBuilder: (context, index) {
                      DateTime datetime = DateTime.parse(
                          invoicelist[index].datetimeUpdated.toString() ==
                                  "None"
                              ? "2024-02-26 04:30:00"
                              : invoicelist[index].datetimeUpdated);
                      String timestamp =
                          datetime.toLocal().toString().substring(0, 19);

                      // Format the DateTime object to a time string with AM/PM and in local timezone

                      // DateFormat outputFormat = DateFormat('hh:mm a');
                      // String convertedTime = outputFormat.format(time3);
                      String date = datetime.toString().substring(0, 10);

                      return CardInvoice(
                        invUrl: invoicelist[index].invoiceUrl.toString(),
                        invcid: invoicelist[index].invoiceId,
                        patientid: invoicelist[index].patientId,
                        aptid: invoicelist[index].appointmentId,
                        name: invoicelist[index].patientName,
                        status: invoicelist[index].invoiceStatus?.toString(),
                        date: date,
                        orderTotal: invoicelist[index].orderTotal?.toDouble(),
                        tax: invoicelist[index].taxAmount?.toDouble(),
                        discount: invoicelist[index].discountAmount,

                        // Add more properties or customize ListTile as needed
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: deviceSize.height * 0.013,
                decoration: const BoxDecoration(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
