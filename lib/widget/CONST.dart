import 'package:casadealerapp/modal_class/login_model.dart';
import 'package:connectivity/connectivity.dart';

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

const String baseUrl =
    'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php';

Map<String, String> headers = {
  'Authorization': 'hXuRUGsEGuhGf6KG',
};
