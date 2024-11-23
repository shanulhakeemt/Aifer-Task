import 'package:aifer_task/core/variables/variables.dart';
import 'package:aifer_task/core/widgets/loader.dart';
import 'package:aifer_task/features/category/view/pages/category_screen.dart';
import 'package:aifer_task/features/category/viewmodel/category_viewmodel.dart';
import 'package:aifer_task/features/home/view/widgets/image_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryRightSideScreen extends ConsumerStatefulWidget {
  const CategoryRightSideScreen({super.key});

  @override
  CategoryRightSideScreenState createState() => CategoryRightSideScreenState();
}

class CategoryRightSideScreenState
    extends ConsumerState<CategoryRightSideScreen> {
  late ScrollController _controller;
  bool _isFetching = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(categoryViewModelProvider.notifier).getCategorizedImages(
            context: context, category: ref.watch(sideBarNameProvider));
      },
    );
    _controller = ScrollController()
      ..addListener(() {
        final isBottom =
            _controller.offset >= _controller.position.maxScrollExtent &&
                !_controller.position.outOfRange;

        if (isBottom && !_isFetching) {
          _isFetching = true; // Set fetching state to true
          ref
              .read(categoryViewModelProvider.notifier)
              .getCategorizedImages(
                  context: context, category: ref.watch(sideBarNameProvider))
              .then((_) {
            _isFetching = false; // Reset fetching state
          });
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * .012, horizontal: w * .042),
      child: Consumer(builder: (context, ref, child) {
        final homeViewModel = ref.watch(categoryViewModelProvider).value;
        final isLoading = ref.watch(categoryViewModelProvider).isLoading;
        return Column(
          children: [
            Expanded(
              child: MasonryGridView.builder(
                controller: _controller,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                ),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                itemCount: homeViewModel == null ? 0 : homeViewModel.length,
                itemBuilder: (context, index) {
                  return ImageCard(url: homeViewModel![index].urls);
                },
              ),
            ),
            if (isLoading)
              SizedBox(height: h * .065, width: h * .065, child: const Loader())
          ],
        );
      }),
    );
  }
}
