// ignore_for_file: use_build_context_synchronously

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/order_total_entity.dart';
import 'package:eva_life_care/features/list_appointment/presentation/providers/orderTotal_provider.dart';
import 'package:eva_life_care/features/list_invoice/presentation/widgets/pdfviewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ActionButtonInvoice extends StatelessWidget {
  String invoiceurl;

  ActionButtonInvoice(this.invoiceurl, {super.key});

  OrderTotalEntity? getTotal;

  @override
  Widget build(BuildContext context) {
    fetchData(BuildContext context) async {
      await Provider.of<OrderTotalProvider>(context, listen: false)
          .eitherFailureOrOrderTotal();
      getTotal =
          Provider.of<OrderTotalProvider>(context, listen: false).orderTotal;
    }

    return PopupMenuButton(
      color: Colors.white,
      child: const Icon(
        Icons.more_vert,
        color: Colors.black,
        size: 25,
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          onTap: () async {
            bool isConnected =
                await NetworkInfoImpl(DataConnectionChecker()).isConnected;
            invoiceurl == "null"
                ? Fluttertoast.showToast(
                    msg: "No invoice found!", gravity: ToastGravity.CENTER)
                : !isConnected
                    ? Fluttertoast.showToast(
                        msg: "No internet connection!",
                        gravity: ToastGravity.CENTER)
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PDFViewerPage(pdfUrl: invoiceurl)),
                      );
          },
          // value: "en",

          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(1),
              child: Icon(
                Icons.remove_red_eye,
                size: 18,
                color: invoiceurl == "null"
                    ? Colors.grey
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 15),
            Text("View Invoice",
                style: TextStyle(
                  color: invoiceurl == "null"
                      ? Colors.grey
                      : Theme.of(context).colorScheme.onPrimary,
                )),
          ]),
        ),
        PopupMenuItem(
          // value: "de",
          onTap: () async {
            bool isConnected =
                await NetworkInfoImpl(DataConnectionChecker()).isConnected;
            printPdf() async {
              var data = await http.get(Uri.parse(invoiceurl));
              await Printing.layoutPdf(onLayout: (_) => data.bodyBytes);
            }

            invoiceurl == "null"
                ? Fluttertoast.showToast(
                    msg: "No invoice found!", gravity: ToastGravity.CENTER)
                : !isConnected
                    ? Fluttertoast.showToast(
                        msg: "No internet connection!",
                        gravity: ToastGravity.CENTER)
                    : printPdf();

            // Printer(url: invoiceurl);
          },
          child: Row(
            children: [
              Icon(Icons.print,
                  size: 18,
                  color: invoiceurl == "null"
                      ? Colors.grey
                      : Theme.of(context).colorScheme.onPrimary

                  // color: greencolor,
                  ),
              const SizedBox(width: 15),
              Text("Print Invoice",
                  style: TextStyle(
                      color: invoiceurl == "null"
                          ? Colors.grey
                          : Theme.of(context).colorScheme.onPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}
