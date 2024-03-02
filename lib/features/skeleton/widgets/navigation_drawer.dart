import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/list_appointment/presentation/pages/list_appointment_page.dart';
import 'package:eva_life_care/features/list_invoice/presentation/pages/list_invoice_page.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  int _selectedIndex = 0;
  String isWidget = '';
  String clLogo = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isWidget = prefs.getString('widget').toString();
    // int uid = prefs.getInt('userId')!.toInt();
    // int cId = prefs.getInt('clientId')!.toInt();
    // String client_name = prefs.getString('client_name').toString();
    String clientlogo = prefs.getString('Logo').toString();
    // final mLimit = prefs.getInt('currentLmt');
    // String messageLimit = mLimit.toString();

    setState(() {
      clLogo = clientlogo;

      // currentLimit = mLimit.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    var screenOrientation = MediaQuery.orientationOf(context);
    Color? textclr = Theme.of(context).colorScheme.onPrimary;
    void onItemTapped(int index, Widget widget) {
      setState(() {
        _selectedIndex = index; // Update the selected index
      });
      Navigator.push(context, MaterialPageRoute(builder: (_) => widget));

      // You can add your logic here based on the selected index
      // For example, navigate to a different page or perform an action
      // based on the selected item.
    }

    return Drawer(
      width: screenOrientation.toString() == 'Orientation.portrait'
          ? deviceSize.width * 0.58
          : screenOrientation.toString() == 'Orientation.landscape' &&
                  deviceSize.height < 500
              ? deviceSize.width * 0.35
              : deviceSize.width * 0.3,

      // MediaQuery.of(context).size.width * 0.28,
      backgroundColor: Colors.white,
      child: ListView(
        // Important: Remove any padding from the ListView.
        // padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 251, 252, 251)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SizedBox(
                  width: screenOrientation.toString() == "Orientation.landscape"
                      ? MediaQuery.of(context).size.width * 0.15
                      : MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.network(clLogo)
                  // child: clLogo.isEmpty
                  //     ? SizedBox()
                  //     : Image.network(
                  //         clLogo,
                  //         height: 30,
                  //         width: 50,
                  //       ),
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 29,
                bottom: 5,
                right: screenOrientation.toString() == 'Orientation.landscape'
                    ? deviceSize.width * 0.028
                    : deviceSize.width * 0.04),
            child: Container(
              width: deviceSize.width * 0.025,
              height: screenOrientation.toString() == 'Orientation.portrait'
                  ? deviceSize.height * 0.05
                  : screenOrientation.toString() == 'Orientation.landscape' &&
                          deviceSize.height < 500
                      ? deviceSize.height * 0.11
                      : deviceSize.height * 0.081,
              decoration: BoxDecoration(
                  color: isWidget == 'listappointments'
                      ? const Color.fromARGB(255, 7, 176, 150)
                      : null,
                  borderRadius: isWidget == 'listappointments'
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))
                      : null),
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: Icon(Icons.dashboard_sharp,
                      size: 15,
                      color: isWidget == 'listappointments'
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface),
                ),

                title: GestureDetector(
                  onTap: () async {
                    bool isConnected =
                        await NetworkInfoImpl(DataConnectionChecker())
                            .isConnected;
                    // ignore: use_build_context_synchronously

                    if (!isConnected) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NoInternet(
                          onPressed: () async {
                            bool isConnected =
                                await NetworkInfoImpl(DataConnectionChecker())
                                    .isConnected;
                            callAgain() {
                              _selectedIndex == 1;
                              isWidget = 'listappointments';

                              onItemTapped(1, const ListAppointmentPage());
                            }

                            if (!isConnected) {
                              Fluttertoast.showToast(
                                  msg: "No internet connection!",
                                  gravity: ToastGravity.CENTER);
                            } else {
                              callAgain();
                            }
                          },
                        ),
                      ));
                    } else {
                      _selectedIndex == 1;
                      isWidget = 'listappointments';

                      onItemTapped(1, const ListAppointmentPage());
                    }
                    // _selectedIndex == 1;
                    // isWidget = 'listappointments';

                    // onItemTapped(1, const ListAppointmentPage());
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => const ListAppointmentPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Text(
                      'Appointments',
                      style: TextStyle(
                        fontSize: screenOrientation.toString() ==
                                'Orientation.landscape'
                            ? MediaQuery.of(context).size.width * 0.016
                            : MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.w500,
                        color: isWidget == 'listappointments'
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                // onTap: () {
                //   // Update the state of the app.
                //   // ...
                // },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: screenOrientation.toString() == 'Orientation.landscape'
                    ? deviceSize.width * 0.028
                    : deviceSize.width * 0.04,
                left: 29,
                bottom: MediaQuery.of(context).size.height * 0.3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.025,
              height: screenOrientation.toString() == 'Orientation.portrait'
                  ? deviceSize.height * 0.05
                  : screenOrientation.toString() == 'Orientation.landscape' &&
                          deviceSize.height < 500
                      ? deviceSize.height * 0.11
                      : deviceSize.height * 0.079,
              decoration: BoxDecoration(
                  color: isWidget == 'listinvoice'
                      ? const Color.fromARGB(255, 7, 176, 150)
                      : null,
                  borderRadius: isWidget == 'listinvoice'
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))
                      : null),
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.025),
                  child: Icon(Icons.payments,
                      size: 15,
                      color: isWidget == 'listinvoice'
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface),
                ),
                title: GestureDetector(
                  onTap: () async {
                    bool isConnected =
                        await NetworkInfoImpl(DataConnectionChecker())
                            .isConnected;
                    // ignore: use_build_context_synchronously

                    if (!isConnected) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NoInternet(
                          onPressed: () async {
                            bool isConnected =
                                await NetworkInfoImpl(DataConnectionChecker())
                                    .isConnected;
                            callAgain() {
                              _selectedIndex == 2;
                              isWidget = 'listinvoice';

                              onItemTapped(2, const ListInvoicePage());
                            }

                            if (!isConnected) {
                              Fluttertoast.showToast(
                                  msg: "No internet connection!",
                                  gravity: ToastGravity.CENTER);
                            } else {
                              callAgain();
                            }

                            // If not connected, attempt login again when retrying
                          },
                        ),
                      ));
                    } else {
                      _selectedIndex == 2;
                      isWidget = 'listinvoice';

                      onItemTapped(2, const ListInvoicePage());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.025),
                    child: Text(
                      'Invoices',
                      style: TextStyle(
                          fontSize: screenOrientation.toString() ==
                                  'Orientation.landscape'
                              ? MediaQuery.of(context).size.width * 0.016
                              : MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.w500,
                          color: isWidget == 'listinvoice'
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Divider(,sty
          //   color: Colors.green,
          // ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // const Expanded(
              //     child: SizedBox(
              //   height: 1,
              // )),
              Padding(
                padding: EdgeInsets.only(
                    bottom:
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? deviceSize.height * 0.03
                            : 0,
                    top: deviceSize.height * 0.19),
                child: SizedBox(
                    width:
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? MediaQuery.of(context).size.width * 0.13
                            : MediaQuery.of(context).size.width * 0.17,
                    height:
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? MediaQuery.of(context).size.height * 0.13
                            : MediaQuery.of(context).size.height * 0.17,
                    child: Image.asset('assets/images/eva_logo.png')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
