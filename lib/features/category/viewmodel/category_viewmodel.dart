import 'dart:async';
import 'package:aifer_task/core/models/image_model.dart';
import 'package:aifer_task/core/utils.dart';
import 'package:aifer_task/features/category/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryViewModelProvider =
    AsyncNotifierProvider<CategoryViewModel, List<ImageModel>>(
  () => CategoryViewModel(),
);

class CategoryViewModel extends AsyncNotifier<List<ImageModel>> {
  int pages = 1;

  late CategoryRepository _categoryRepository;

  clearPages() {
    pages = 1;
  }

  clearCategoryList() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => Future.value([]));
  }

  getCategorizedImages(
      {required BuildContext context, required String category}) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(microseconds: 1));
    final res = await _categoryRepository.getCategorizedImages(
        pages: pages, category: category);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        final oldUsers = [...state.value!];
        state = await AsyncValue.guard(
          () => Future.value(oldUsers + r),
        );
      },
    );
    pages++;
  }

  @override
  FutureOr<List<ImageModel>> build() async {
    _categoryRepository = ref.watch(categoryRepositoryProvider);
    return [];
  }
}
