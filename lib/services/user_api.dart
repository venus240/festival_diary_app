// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/models/user.dart';

class UserApi {
  final Dio dio = Dio();

  Future<bool> registerUser(User user, File? userFile) async {
    try {
      final formData = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
          'userImage': await MultipartFile.fromFile(userFile.path,
              filename: userFile.path.split('/').last,
              contentType:
                  DioMediaType('image', userFile.path.split('.').last)),
      });

      final responseData = await dio.post(
        'http://172.17.35.11:3030/user/',
        data: formData,
        options: Options(
          headers: {
            'content-type': 'multipart/form-data',
          },
        ),
      );

      if (responseData.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return false;
    }
  }
}
