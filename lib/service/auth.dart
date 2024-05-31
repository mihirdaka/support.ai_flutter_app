import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supportu_flutter_app/constant/api_enpoints.dart';
import 'package:supportu_flutter_app/data/auth.dart';
import 'package:supportu_flutter_app/data/chat.dart';
import 'package:supportu_flutter_app/provider/user_helper.dart';

class AuthClient {
  final Dio _dio = Dio();
  final ApiEnpoints apiEnpoints = ApiEnpoints();

  Future<RegisterResponse?> registerUser(userData) async {
    //IMPLEMENT USER REGISTRATION
    try {
      Response response = await _dio.post(
        apiEnpoints.BaseUrl + apiEnpoints.registerUser,
        data: json.encode(userData),
      );
      // print(response);
      switch (response.statusCode) {
        case 200:
        case 201:
          // final jData = json.decode(response.data);
          return RegisterResponse.fromJson(response.data);
        case 401:
          return null;
        default:
          return RegisterResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      print(e.toString());
      return RegisterResponse.fromJson(e.response?.data);
    }
  }

  Future<RegisterResponse?> login(Map<String, dynamic> user) async {
    //IMPLEMENT USER LOGIN
    try {
      Response response = await _dio.post(
        apiEnpoints.BaseUrl + apiEnpoints.loginUser,
        data: json.encode(user),
      );
      // //print(response);
      switch (response.statusCode) {
        case 200:
        case 201:
          // final jData = json.decode(response.data);
          //print(response.data);
          return RegisterResponse.fromJson(response.data);
        case 400:
          return RegisterResponse.fromJson(response.data);
        default:
          return RegisterResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      //print('i got error \n\n\n\n');
      //print(e.toString());
      return RegisterResponse.fromJson(e.response?.data);

      // return e.response!.data;
    }
  }

  Future<ChatResponse?> chatWithAi(Map<String, dynamic> data) async {
    try {
      String? token = userHelper.getToken;

      final Map<String, String> headers = apiEnpoints.headers;
      headers.addAll({
        "Authorization": token ?? '',
      });
      Response? response = await _dio.post(
        apiEnpoints.BaseUrl + apiEnpoints.chat,
        data: json.encode(data),
        options: Options(headers: headers),
      );

      // //print(response);
      switch (response.statusCode) {
        case 200:
        case 201:
          // final jData = json.decode(response.data);
          //print(response.data);
          return ChatResponse.fromJson(response.data);
        case 400:
          return ChatResponse.fromJson(response.data);
        default:
          return ChatResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      //print('i got error \n\n\n\n');
      //print(e.toString());

      return ChatResponse.fromJson(e.response?.data);

      // return e.response!.data;
    }
  }

  Future<File?> uploadAudioFile(File audioFile) async {
    try {
      String? token = userHelper.getToken;
      FormData formData = FormData.fromMap(
          {"audio": await MultipartFile.fromFile(audioFile.path)});

      final Map<String, String> headers = apiEnpoints.headers;
      headers.addAll({
        "Authorization": token!,
      });
      Response response = await _dio.put(
        apiEnpoints.BaseUrl + apiEnpoints.talk,
        data: formData,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          headers: headers,
          responseType: ResponseType.bytes,
        ),
      );
      // //print(response.data);
      switch (response.statusCode) {
        case 200:
        case 201:
          final Directory directory = await getApplicationDocumentsDirectory();
          final File file = File('${directory.path}/response.mp3');
          await file.writeAsBytes(response.data);
          return file;
        // return file;
        case 401:
          return null;
        default:
          return null;
      }
    } catch (e) {
      // //print('i got error \n\n\n\n');
      //print(e.toString());
      return null;
    }
  }
}
