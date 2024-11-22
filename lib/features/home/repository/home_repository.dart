import 'dart:convert';
import 'dart:io';

import 'package:aifer_task/core/constants/server_constants.dart';
import 'package:aifer_task/core/failure/failure.dart';
import 'package:aifer_task/core/models/image_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<Either<AppFailure, String>> downloadImageToStorage(
      String imageUrl) async {
    try {
      // Check storage permission
      if (await Permission.storage.request().isGranted) {
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          final directory = await getExternalStorageDirectory();
          final downloadPath =
              '${directory!.path}/downloaded_image${DateTime.now().microsecond}.jpg';

          // Save file
          final file = File(downloadPath);
          await file.writeAsBytes(response.bodyBytes);

          return right("Image downloaded to: $downloadPath");
        } else {
          return left(AppFailure("Failed to download image"));
        }
      } else {
        return left(AppFailure("Storage permission denied"));
      }
    } catch (e) {
      return left(AppFailure("Error: $e"));
    }
  }
}
