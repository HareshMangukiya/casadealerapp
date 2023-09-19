import 'dart:io';

import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/login_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../modal_class/convertblockorder.dart';
convertblockorder? edit;
Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

usermodal? userData;
ViewCart? viewaddtocart;

const String baseUrl =
    'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php';

Map<String, String> headers = {
  'Authorization': 'hXuRUGsEGuhGf6KG',
};


catlog(value)async{
  var response =
      await http.get(
      Uri.parse(
          (value.toString())));
  String fileName =
      url
          .toString()
          .split('/')
          .last;
  Directory?
  storageDirectory =
      await getExternalStorageDirectory();
  String
  directoryPath =
      storageDirectory!
          .path;
  File file = File(
      '$directoryPath/$fileName');
  // Directory directory = await getApplicationDocumentsDirectory();
  await file.writeAsBytes(
      response
          .bodyBytes);
  String filePath =
      '${storageDirectory.path}/$fileName';

  try {
    final result =
        await OpenFile
        .open(
        filePath);
  } catch (e) {
    print(
        e.toString());
  }
}
