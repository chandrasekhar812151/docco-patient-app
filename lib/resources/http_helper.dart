import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:doctor_patient/config.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpHelper {
  BaseOptions options = BaseOptions(
    baseUrl: Config.apiUrl,
    connectTimeout: Duration(milliseconds: 40000),
    receiveTimeout: Duration(milliseconds: 40000),
  );

  Dio? dio;

  HttpHelper() {
    dio = Dio(options);
  }

  Future<Response?> get(url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response;
    try {
      print('SENDING REQUEST');
      print('url: $url');
      response = await dio?.get(
        url,
        options: Options(headers: {
          'Authorization': prefs.getString('token'),
          'Accept': 'application/json'
        }, responseType: ResponseType.json),
      );
      print('Recieved data');
      print(response?.data);
    } on DioError catch (e) {
      print('Error occurred while getting data from the server');
      print(e.toString());
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        throw DoccoException(e.response?.data, e.response!.statusCode as int);
      } else {
        print(e.message);
        throw e;
      }
    }

    return response;
  }

  Future<Response?> post(url, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response;
    try {
      print('SENDING REQUEST');
      print('url: $url');
      print('data: $data');
      response = await dio?.post(
        url,
        data: data,
        options: Options(headers: {
          'Authorization': prefs.getString('token'),
          'Accept': 'application/json'
        }, responseType: ResponseType.json),
      );
      print('Recieved data');
      print(response?.data);
    } on DioError catch (e) {
      print('Error occurred while sending post request to the server');
      print(e.toString());
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        throw DoccoException(e.response?.data, e.response?.statusCode as int);
      } else {
        print(e.message);
        throw e;
      }
    }

    return response;
  }

  Future<Response?> put(url, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response;
    try {
      response = await dio?.put(
        url,
        data: data,
        options: Options(headers: {
          'Authorization': prefs.getString('token'),
          'Accept': 'application/json'
        }, responseType: ResponseType.json),
      );
    } on DioError catch (e) {
      print('Error occurred while sending put request to the server');
      print(e.toString());
      if (e.response != null) {
        throw DoccoException(e.response?.data, e.response?.statusCode as int);
      } else {
        print(e.message);
        throw e;
      }
    }

    return response;
  }

  Future<Response?> delete(url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response;
    try {
      response = await dio?.delete(
        url,
        options: Options(headers: {
          'Authorization': prefs.getString('token'),
          'Accept': 'application/json'
        }, responseType: ResponseType.json),
      );
    } on DioError catch (e) {
      print('Error occurred while sending delete request to the server');
      print(e.toString());
      if (e.response != null) {
        throw DoccoException(e.response?.data, e.response?.statusCode as int);
      } else {
        print(e.message);
        throw e;
      }
    }

    return response;
  }

  Future<Response?> postFormData(url, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response;

    try {
      response = await dio?.post(
        url,
        data: FormData.fromMap(data),
        options: Options(headers: {
          'Authorization': prefs.getString('token'),
          'Accept': 'application/json'
        }, responseType: ResponseType.json),
      );

      print('Response: ${response?.data}');
    } on DioError catch (e) {
      print('Error occurred while getting data from the server');
      print(e.toString());
      print(e.message);
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        throw e;
      }
    }

    return response;
  }
}
