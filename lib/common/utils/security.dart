import 'dart:convert';
import 'dart:math';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app/common/widgets/toast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// SHA256
String duSHA256(String input) {
  String salt = 'EIpWsyfiy@R@X#qn17!StJNdZK1fFF8iV6ffN!goZkqt#JxO'; // 加盐
  var bytes = utf8.encode(input + salt);
  var digest = sha256.convert(bytes);

  return digest.toString();
}

String getRandomString(int length) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

String getOrderNumber() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

Future<bool> request_permission(Permission permission) async {
  var permission_status = await permission.status;
  print("permission_status------${permission_status}");
  if (permission_status != PermissionStatus.granted) {
    //here
    var status = await permission.request();

    if (status != PermissionStatus.granted) {
      //here
      print("denied");
      toastInfo(msg: "Please open the setting page to set permissions");
      await openAppSettings();
      return false;
    }
  }

  return true;
}

Future<bool> printPdf(TransferCollectionData item) async {
  final pdf = pw.Document();
  final font = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");

  final imageBytes = await rootBundle.load('assets/icons/logo1.png');
  final image = pw.MemoryImage(imageBytes.buffer.asUint8List());

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      textDirection: pw.TextDirection.rtl,
      build: (pw.Context context) {
        return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Center(
                child: pw.Image(image, width: 150, height: 150),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text("Order ID:  ${item.id}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text("Name:  ${item.name}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text("Phone Number:  ${item.phone}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text("Amount:  ${item.amount}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text("Time:  ${timeFormated(item.createdAt)}",
                    style: pw.TextStyle(fontSize: 20, font: pw.Font.ttf(font))),
              ),
            ]); // Center
      }));

  return await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
