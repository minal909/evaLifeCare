// ignore_for_file: no_logic_in_create_state

import 'package:eva_life_care/features/book%20appointment/data/models/list_service_model.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/pages/apt_date_time.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/pages/apt_details.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/pages/basic_details.dart';
import 'package:flutter/material.dart';

TextEditingController charges = TextEditingController();

// ignore: must_be_immutable
class BookAppointment extends StatefulWidget {
  Widget widget;
  List<Result> serviceResult;
  List idprooflist;
  List services;
  String page;
  BookAppointment(this.widget, this.serviceResult, this.idprooflist,
      this.services, this.page,
      {super.key});

  @override
  _BookAppointmentState createState() =>
      _BookAppointmentState(serviceResult, idprooflist, services, page);
}

class _BookAppointmentState extends State<BookAppointment>
    with SingleTickerProviderStateMixin {
  List<Result> serviceResult = [];
  List idprooflist = [];
  List services = [];
  String page;

  _BookAppointmentState(
      this.serviceResult, this.idprooflist, this.services, this.page);

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  final TextEditingController typeAheadController = TextEditingController();
  final TextEditingController typeAheadController2 = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();

  TextEditingController age = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController autoaddress = TextEditingController();

  TextEditingController username = TextEditingController();

  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  TextEditingController zipcode = TextEditingController();
  int idTypeId = 0;

  TextEditingController idnumber = TextEditingController();
  TextEditingController refDoc = TextEditingController();
  String? idproofDoc;
  int? proofIdNo;

  GlobalKey<BasicDetailsState> firstTabKey = GlobalKey<BasicDetailsState>();
  GlobalKey<AppointmentDetailsState> secondTabKey =
      GlobalKey<AppointmentDetailsState>();
  TabController? tabController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => widget.widget));
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: const Text("Book Appointment"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              automaticIndicatorColorAdjustment: true,
              unselectedLabelColor: Colors.amber,
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              tabs: [
                Padding(
                  padding: EdgeInsets.only(bottom: deviceSize.height * 0.006),
                  child: const Text(
                    'Personal',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: deviceSize.height * 0.006),
                  child: const Text(
                    'Appointments',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: deviceSize.height * 0.006),
                  child: const Text(
                    'Date & Time',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                //    TextButton(onPressed: () {}, child: const Text('Basics')),
                // TextButton(onPressed: () {}, child: const Text('Appointments')),
                // TextButton(onPressed: () {}, child: const Text('Date & Time'))
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,

            // physics: NeverScrollableScrollPhysics(),
            children: [
              BasicDetails(
                widget.widget,
                typeAheadController,
                typeAheadController2,
                firstname,
                lastname,
                age,
                email,
                autoaddress,
                username,
                address,
                city,
                state,
                country,
                zipcode,

                idnumber,
                widget.idprooflist,
                'Passport',
                idproofDoc,

                // department,
                // designation,
                // email,
                // idnumber,
                // name,
                // state,
                // username,
                // zipcode
              ),
              AppointmentDetails(
                  widget.widget, refDoc, serviceResult, '', widget.services),
              AppointmentDateTime(
                  widget.widget,
                  page,
                  '${typeAheadController2.text}${typeAheadController.text}',
                  firstname.text,
                  lastname.text,
                  age.text,
                  email.text,
                  autoaddress.text,
                  username.text,
                  address.text,
                  city.text,
                  state.text,
                  country.text,
                  zipcode.text,
                  idnumber.text,
                  refDoc.text)
            ],
          )),
    );
  }
}
