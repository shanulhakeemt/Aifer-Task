import 'dart:async';
import 'package:aifer_task/core/models/image_model.dart';
import 'package:aifer_task/core/utils.dart';
import 'package:aifer_task/features/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider =
    AsyncNotifierProvider<HomeViewModel, List<ImageModel>>(
  () => HomeViewModel(),
);

class HomeViewModel extends AsyncNotifier<List<ImageModel>> {
  int _pages = 1;
  late HomeRepository _homeRepository;

  getImages({required BuildContext context}) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(microseconds: 1));
    final res = await _homeRepository.getImages(pages: _pages);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        final oldUsers = [...state.value!];
        state = await AsyncValue.guard(
          () => Future.value(oldUsers + r),
        );
      },
    );
    _pages++;
  }

  Future<void> downloadImageToStorage(String url, BuildContext context) async {
    state = const AsyncLoading();
    final res = await _homeRepository.downloadImageToStorage(url);
    state = await AsyncValue.guard(
          () => Future.value([...state.value!]),
        );
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, r);
      },
    );
  }

  @override
  FutureOr<List<ImageModel>> build() async {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return [];
  }
}
