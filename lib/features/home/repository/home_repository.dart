import 'dart:convert';

import 'package:aifer_task/core/constants/server_constants.dart';
import 'package:aifer_task/core/failure/failure.dart';
import 'package:aifer_task/core/models/image_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
 part 'home_repository.g.dart';
@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, List<ImageModel>>> getImages(
      {required int pages}) async {
    try {
      final uri = Uri.parse(
          '${ServerConstants.baseUrl}photos?page=$pages&client_id=${ServerConstants.accessKey}');

      final res = await http.get(uri);

      final resBodyMap = jsonDecode(res.body);

      if (res.statusCode == 200) {
        final m = (resBodyMap as List).map(
          (e) {
            return ImageModel.fromMap(e);
          },
        ).toList();

        return right(m);
      } else {
        return left(AppFailure(resBodyMap['errors'][0]));
      }
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
