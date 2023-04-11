import 'dart:convert';
import 'dart:io';
import 'package:casadealerapp/widget/CustomException.dart';
import 'package:casadealerapp/widget/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Authprovider with ChangeNotifier {
  Map<String, String> headers = {
    'Authorization': 'hXuRUGsEGuhGf6KG',
  };

  Future<http.Response> signupapi(Map<String, String> bodyData) async {
    var body = jsonEncode(bodyData);
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php/?action=signup';
    var responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      responseJson = responses(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> loginapi(Map<String, dynamic> bodyData) async {
    var body = jsonEncode(bodyData);
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php/?action=login';
    var responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      responseJson = responses(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> editproapi(Map<String, dynamic> bodyData) async {
    var body = jsonEncode(bodyData);
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php/?action=update_distributor_data';
    var responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      responseJson = responses(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> profile(Map<String, String> bodyData) async {
    var body = jsonEncode(bodyData);
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php/?action=fetch_distributor_data';
    var responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      responseJson = responses(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> products(Map<String, String> bodyData) async {
    var body = jsonEncode(bodyData);
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php/?action=fetch_products';
    var responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      responseJson = responses(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  Future<http.Response> user(Map<String, dynamic> bodyData) async {
    print(bodyData);
    var body = jsonEncode(bodyData);
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php/?action=fetch_block_quantity';
    var responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      print(response.statusCode);
      responseJson = responses(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;

    print(responseJson);
  }
  Future<http.Response> logo(Map<String, dynamic> bodyData) async {
    const url =
        'https://distributor-app.fableadtechnolabs.com/admin/api/ajax.php/?action=banner_logo_app_change';
    var responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: bodyData, headers: headers)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      print(response.statusCode);
      responseJson = responses(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;

    print(responseJson);
  }


}