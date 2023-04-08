import 'dart:io';


import 'package:casadealerapp/widget/response.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class Productprovider with ChangeNotifier {
  Map<String, String> headers = {
    'Authorization': 'hXuRUGsEGuhGf6KG',
  };
  Future<http.Response> allcatogeryapi(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=all_category_display';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> selectcategorydisplay(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=category_wise_product';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> searchproduct(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=searching_products';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> view_product_order(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=view_order';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> product_orderDetail(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=order_details';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> product2_color(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=all_color_display';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> product2_image(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=single_product_display';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> product2_selectimage(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=color_select_display_img';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }


  Future<http.Response> product2_displaycolorselect(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=color_select_display_all_data';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> forgot(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=forgot_password';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> product2blockprovider(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=block_produt_wise';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> product2addtocartprovider(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=add_to_cart';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
   }

  Future<http.Response> summaryBlockViewProvider(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=view_block_product_single';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> viewcartapi(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=view_add_to_cart_product_single';
    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> profileProvider(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=fetch_distributor_data';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> UpdateprofileProvider(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=update_distributor_data';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> updatePasswordProvider(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=change_password_page';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> blockViewProvider(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=view_order_block';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> summeryEditBlockProvider(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=edit_block_single_product';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> summeryEditCartProvider(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=edit_add_to_cart_single_product';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> comfirmblockapi(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=confirm_block_order';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> confirmaddtocartapi(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=confirm_add_to_cart_order';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> oredrdetailap(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=order_details';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> convertblockorderapi(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=block_order_convert_confirm';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> unblockblockorderapi(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=unblock_blockorder';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> orderdetaildetailedit(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=order_edit_stock';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> canclerequestapi(Map<String, dynamic> bodyData) async {
    const url = 'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php?action=cancle_order_request';

    var responseJson;

    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
}
