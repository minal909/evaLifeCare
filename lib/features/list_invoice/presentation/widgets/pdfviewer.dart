import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;

  const PDFViewerPage({super.key, required this.pdfUrl});

  @override
  // ignore: library_private_types_in_public_api
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController _pdfViewController;
  bool _isLoading = true;
  String _localFilePath = '';

  @override
  void initState() {
    super.initState();
    downloadPDF();
  }

  Future<void> downloadPDF() async {
    var response = await http.get(Uri.parse(widget.pdfUrl));
    String pdfname = widget.pdfUrl.split('/').last;
    print('==============${widget.pdfUrl}');

    var dir = await Directory.systemTemp.createTemp();
    var file = File('${dir.path}/$pdfname');

    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      _isLoading = false;
      _localFilePath = file.path;
    });
    print('file name------------------$_localFilePath');
  }

  void _shareFile() {
    Share.shareFiles([_localFilePath], text: 'Sharing PDF');
  }

  Future<bool> downloadInvoicePdf(String url, String fileName) async {
    print('lurl is ---------------------------------${widget.pdfUrl}');
    Directory directory;
    Dio dio = Dio();

    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/Eva Life Care";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File("${directory.path}/$fileName");
        await dio.download(
          url,
          saveFile.path,
        );
        Fluttertoast.showToast(
            msg: "Download complete!", gravity: ToastGravity.CENTER);

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () async {
              bool isConnected =
                  await NetworkInfoImpl(DataConnectionChecker()).isConnected;
              String pdfname = widget.pdfUrl.split('/').last;
              !isConnected
                  ? Fluttertoast.showToast(
                      msg: "No internet connection!",
                      gravity: ToastGravity.CENTER)
                  : downloadInvoicePdf(widget.pdfUrl, 'elcareinvoice$pdfname');
              // Use _shareFile function for download callback
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              var data = await http.get(Uri.parse(widget.pdfUrl));
              await Printing.layoutPdf(onLayout: (_) => data.bodyBytes);
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              _shareFile(); // Use _shareFile function for download callback
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_localFilePath.isNotEmpty)
            PDFView(
              filePath: _localFilePath,
              onViewCreated: (PDFViewController controller) {
                _pdfViewController = controller;
                _pdfViewController.setPage(0);
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
              },
              onError: (error) {
                print(error);
              },
              onRender: (pages) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
