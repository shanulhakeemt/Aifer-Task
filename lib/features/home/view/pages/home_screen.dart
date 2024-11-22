import 'package:aifer_task/core/theme/app_pallete.dart';
import 'package:aifer_task/core/variables/variables.dart';
import 'package:aifer_task/core/widgets/loader.dart';
import 'package:aifer_task/features/home/view/widgets/image_card.dart';
import 'package:aifer_task/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController _controller;
  bool _isFetching = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(homeViewModelProvider.notifier).getImages(context: context);
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
              .read(homeViewModelProvider.notifier)
              .getImages(context: context)
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
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        surfaceTintColor: Pallete.backgroundColor,
        title: Text(
          'All',
          style: GoogleFonts.roboto(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: h * .01, horizontal: w * .025),
        child: Consumer(builder: (context, ref, child) {
          final homeViewModel = ref.watch(homeViewModelProvider).value;
          final isLoading = ref.watch(homeViewModelProvider).isLoading;
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _controller,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 8.0, // Space between columns
                    mainAxisSpacing: 8.0, // Space between rows
                  ),
                  itemCount: homeViewModel == null ? 0 : homeViewModel.length,
                  itemBuilder: (context, index) {
                    return ImageCard(
                        url: homeViewModel![index].urls);
                  },
                ),
              ),
              if (isLoading)
                SizedBox(
                    height: h * .065, width: h * .065, child: const Loader())
            ],
          );
        }),
      ),
    );
  }
}
