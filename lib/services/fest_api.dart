import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/models/user.dart';

class FestApi {
  final Dio dio = Dio();

  Future<bool> addFest(Fest fest, File? festFile) async {
    try {
      final formData = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festState': fest.festState,
        'festCost': fest.festCost,
        'userId': fest.userId,
        'festNumDay': fest.festNumDay,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(festFile.path,
              filename: festFile.path.split('/').last,
              contentType:
                  DioMediaType('image', festFile.path.split('.').last)),
      });

      final responseData = await dio.post(
        '$baseurl/fest/',
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
