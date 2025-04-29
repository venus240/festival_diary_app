import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/constants/baseurl_constant.dart';
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
        '$baseurl/user/',
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

  Future<User> checkUser(User user) async {
    try {
      final responseData = await dio.get(
        '$baseurl/user/${user.userName}/${user.userPassword}/',
      );

      if (responseData.statusCode == 200) {
        return User.fromJson(responseData.data['info']);
      } else {
        return User();
      }
    } catch (err) {
      print('Exception: ${err}');
      return User();
    }
  }

  Future<User> updateUser(User user, File? userFile) async {
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

      final responseData = await dio.put(
        '$baseurl/user/${user.userId}',
        data: formData,
        options: Options(
          headers: {
            'content-type': 'multipart/form-data',
          },
        ),
      );

      if (responseData.statusCode == 200) {
        return User.fromJson(responseData.data["info"]);
      } else {
        return User();
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return User();
    }
  }
}
