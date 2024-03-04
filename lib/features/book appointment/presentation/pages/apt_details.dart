import 'package:eva_life_care/features/book%20appointment/business/entities/list_doctor.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/list_doctor_model.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/list_service_model.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/pages/book_apt_form.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_doctor_provider.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable

var formKey2 = GlobalKey<FormState>();
int sid = 0;
int branchid = 0;
int userId = 0;

// ignore: must_be_immutable
class AppointmentDetails extends StatefulWidget {
  Widget widget1;
  TextEditingController refDoc;
  List<Result> serviceResult1;
  String selecteddoctor;
  List servicelist1;

  AppointmentDetails(this.widget1, this.refDoc, this.serviceResult1,
      this.selecteddoctor, this.servicelist1,
      {super.key});

  @override
  // ignore: no_logic_in_create_state
  AppointmentDetailsState createState() => AppointmentDetailsState(
      widget1, refDoc, serviceResult1, selecteddoctor, servicelist1);
}

// Create a corresponding State class.
// This class holds data related to the form.
class AppointmentDetailsState extends State<AppointmentDetails>
    with AutomaticKeepAliveClientMixin {
  String doctorIs = 'Select doctor';

// with AutomaticKeepAliveClientMixin

  @override
  bool get wantKeepAlive => true;
  Widget widget1;

  TextEditingController refDoc;
  List<Result> serviceResult1 = [];
  List listDoctor = [];
  String selecteddoctor = '';
  List servicelist1 = [];

  AppointmentDetailsState(this.widget1, this.refDoc, this.serviceResult1,
      this.selecteddoctor, this.servicelist1);

  double amount = 0;
  List doctorsList = [];
  List<Result> sList = [];
  String? selectedDoctor;
  List listOfDoctor = [''];
  ListDoctorProvider listdoctorprovider = ListDoctorProvider();
  ListDoctorEntity? listdoctorentity;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<AppointmentDetailsState>.
  MyProfileEntity? myprofile;
  List doctorList = ['Select doctor'];
  List doctorList1 = ['Select doctor'];
  String? docis = 'Select doctor';
  var firstTabState;
  @override
  void initState() {
    // bool light = false;
    // TODO: implement initState
    super.initState();

    // storedContext = contextdd
  }

  late final ListDoctorModel doctorsData;

  getListDoc(ListDoctorModel entityDoctor) {
    doctorList = [];
    doctorList1 = ['Select doctor'];
    for (int i = 0; i <= entityDoctor.doctorResult.length - 1; i++) {
      doctorList1.add(
          '${entityDoctor.doctorResult[i].firstname} ${entityDoctor.doctorResult[i].lastname}');
    }
    setState(() {
      doctorList = doctorList1;
    });

    doctorsData = entityDoctor;
  }

  getDoc(int id, String service, BuildContext context,
      ListDoctorProvider provider) async {
    ListDoctorEntity? doctorEntity;

    ListDoctorModel response =
        await provider.getListDoctor(clientid: clientID, serviceid: id);
    // List<DoctorResult> docResult = List<DoctorResult>.from(
    //     response["result"].map((x) => DoctorResult.fromJson(x)));

    // ignore: avoid_print

    getListDoc(response);
  }

  bool serviceChanged = false;
  String doctor = 'Select doctor';
  String doctorval = '';

  getIds(String doctor) {
    for (int i = 0; i <= doctorsData.doctorResult.length - 1; i++) {
      String val =
          '${doctorsData.doctorResult[i].firstname} ${doctorsData.doctorResult[i].lastname}';
      if (val.contains(doctor.toString())) {
        setState(() {
          branchid = doctorsData.doctorResult[i].branchId;
          userId = doctorsData.doctorResult[i].userId;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // updateDoc(String serviceIs) {
    //   doctorList = ['Select doctor'];
    //   doctorIs = 'Select doctor';
    //   doctorList1 = ['Select doctor'];
    //   ListDoctorEntity? doctorEntity;
    //   for (int i = 0; i <= sList.length - 1; i++) {
    //     if (sList[i].name == serviceIs) {
    //       sid = sList[i].id;
    //       charges.text = sList[i].amount.toString();
    //       print('service id is===================$sid');
    //     }
    //   }

    //   Provider.of<ListDoctorProvider>(context, listen: false)
    //       .eitherFailureOrListDoctor(serviceId: sid, clientid: clientID);
    //   doctorEntity =
    //       Provider.of<ListDoctorProvider>(context, listen: false).listdoctor;

    //   doctorList = ['Select doctor'];
    //   doctorIs = 'Select doctor';
    //   doctorList1 = ['Select doctor'];
    //   for (int i = 0; i <= doctorEntity!.result.length - 1; i++) {
    //     doctorList1.add(
    //         '${doctorEntity.result[i].firstname} ${doctorEntity.result[i].lastname}');
    //   }

    //   setState(() {
    //     doctorList = doctorList1;
    //   });
    //   print('doctor list new ++++++++++++++++ --------------$doctorList');
    // }

    // super.build(context); // Required to maintain state

    Size deviceSize = MediaQuery.of(context).size;
    var screenOrientation = MediaQuery.orientationOf(context);
    Widget sizedbox = SizedBox(
      height: deviceSize.height * 0.04,
    );
    // myprofile = Provider.of<MyProfileProvider>(context).myProfile;
    // Failure? failure = Provider.of<MyProfileProvider>(context).failure;
    late Widget widget;
    // refDoc.text = 'Mr.richard';
    // charges.text = '3000';
    // paidAmt.text = '1200';

    List servicelist12 = [];
    String? thisservice;

    servicelist12 = servicelist1;

    // serviceList = widget.serviceResult1;
    selectedDoctor = selecteddoctor;
    sList = serviceResult1;

    // Build a Form widget using the _formKey created above.
    // super.build(context); // Ensure to call super.build
    super.build(context); // Ensure to call super.build

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget1));
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              body: widget = SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: deviceSize.height * 0.04,
              left: deviceSize.width * 0.025,
              right: deviceSize.width * 0.025),
          child: Center(
            child: Form(
              key: formKey2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textformfield(refDoc, 'Reference doctor', 'Reference doctor',
                      TextInputType.name, false),
                  screenOrientation.toString() == 'Orientation.landscape'
                      ? sizedbox
                      : const SizedBox(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: DropdownButtonFormField(
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          labelText: "Service",
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          hintText: "Service",
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          errorStyle: const TextStyle(fontSize: 0.05),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)))),
                      items: servicelist12
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ))
                          .toList(),
                      value: thisservice,
                      onChanged: (value) async {
                        doctorIs = 'Select doctor';

                        var listdoctorprovider =
                            Provider.of<ListDoctorProvider>(context,
                                listen: false);

                        for (int i = 0; i <= sList.length - 1; i++) {
                          if (sList[i].name == value.toString()) {
                            sid = sList[i].id;
                            charges.text = sList[i].amount.toString();
                          }
                        }

                        thisservice = value;

                        await getDoc(sid, thisservice.toString(), context,
                            listdoctorprovider);

                        serviceChanged = true;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter value';
                        }
                        return null;
                      },
                    ),
                  ),
                  screenOrientation.toString() == 'Orientation.landscape'
                      ? sizedbox
                      : const SizedBox(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: DropdownButtonFormField(
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          labelText: "Select doctor",
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          hintText: 'Select doctor',
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          errorStyle: const TextStyle(fontSize: 0.05),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)))),
                      items: doctorList
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ))
                          .toList(),
                      value: doctorIs,
                      onChanged: (value) {
                        setState(() {
                          doctorIs = value.toString();
                        });

                        serviceChanged = false;
                        getIds(doctorIs);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter value';
                        }
                        return null;
                      },
                    ),
                  ),
                  screenOrientation.toString() == 'Orientation.landscape'
                      ? sizedbox
                      : const SizedBox(),
                  textformfield(charges, 'Charges', 'Charges',
                      TextInputType.number, true),
                  screenOrientation.toString() == 'Orientation.landscape'
                      ? sizedbox
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(bottom: deviceSize.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: deviceSize.width * 0.3,
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
                              // Validate returns true if the form is valid, or false otherwise.
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceSize.width * 0.3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  // Color.fromARGB(255, 7, 176, 150),
                                  Theme.of(context).colorScheme.onPrimary,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (formKey2.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                                DefaultTabController.of(context).animateTo(2);
                              }
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
              // : failure != null
              //     ? widget = Expanded(
              //         child: Center(
              //           child: Text(
              //             failure.errorMessage,
              //             style: const TextStyle(fontSize: 20),
              //           ),
              //         ),
              //       )
              //     : widget = const Expanded(
              //         child: Center(
              //           child: CircularProgressIndicator(
              //             backgroundColor: Colors.white,
              //             color: Colors.orangeAccent,
              //           ),
              //         ),
              //       )
              )),
    );
  }

  Widget textformfield(TextEditingController controller, String labelText,
          String hintText, final TextInputType keyboardType, bool redaOnly) =>
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextFormField(
          readOnly: redaOnly,
          style: Theme.of(context).textTheme.bodySmall,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            errorStyle: const TextStyle(fontSize: 0.05),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );
}
