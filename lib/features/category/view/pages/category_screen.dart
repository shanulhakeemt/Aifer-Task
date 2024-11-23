import 'package:aifer_task/core/theme/app_pallete.dart';
import 'package:aifer_task/core/variables/variables.dart';
import 'package:aifer_task/features/category/view/pages/category_right_side_screen.dart';
import 'package:aifer_task/features/category/viewmodel/category_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final sideBarIndexProvider = StateProvider<int>(
  (ref) => 0,
);
final sideBarNameProvider = StateProvider<String>(
  (ref) => 'Anime',
);

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const tabNames = [
    'Anime',
    'Cartoon',
    'Movies',
    'Games',
    'Sports',
    'Animal',
    'Birds',
    'Nature',
    'Cars',
    'Bikes',
  ];

  void updateSideBarInxAndName(WidgetRef ref, int index) {
    ref.read(categoryViewModelProvider.notifier).clearCategoryList();

    ref.read(categoryViewModelProvider.notifier).clearPages();

    ref.read(sideBarIndexProvider.notifier).update(
          (state) => index,
        );

    ref.read(sideBarNameProvider.notifier).update(
          (state) => tabNames[index],
        );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
    _tabController.animation?.addListener(() {
      double? animationValue = _tabController.animation?.value;

      if (animationValue != null) {
        int newIndex = animationValue.round();

        if (newIndex != ref.watch(sideBarIndexProvider)) {
          print("dd");
          _onTabChange(newIndex); // Call your tab change logic
        }
      }
    });
  }

  void _onTabChange(int newIndex) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(sideBarIndexProvider.notifier).update(
              (state) => newIndex,
            );
        ref.read(sideBarNameProvider.notifier).update(
              (state) => tabNames[newIndex],
            );
        ref.read(categoryViewModelProvider.notifier).clearCategoryList();
        ref.read(categoryViewModelProvider.notifier).clearPages();
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Pallete.secondoryBlackColor,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * .04),
                  child: Column(children: [
                    SizedBox(
                      height: h * .012,
                    ),
                    ...List.generate(
                      10,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(top: h * .045),
                          child: GestureDetector(
                            onTap: () {
                              updateSideBarInxAndName(ref, index);
                              _tabController.animateTo(index);
                            },
                            child: AnimatedContainer(
                              height: h * .05,
                              decoration: BoxDecoration(
                                  color:
                                      ref.watch(sideBarIndexProvider) == index
                                          ? Pallete.greenColor
                                          : Pallete.transparentColor,
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: Pallete.greenColor)),
                              duration: const Duration(milliseconds: 200),
                              child: Center(
                                child: Text(
                                  tabNames[index],
                                  style: GoogleFonts.poppins(
                                      color: ref.watch(sideBarIndexProvider) ==
                                              index
                                          ? Pallete.backgroundColor
                                          : Pallete.greenColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: w * .036),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: h * .013,
                    ),
                  ]),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: Pallete.backgroundColor,
              child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                    10,
                    (index) {
                      return const CategoryRightSideScreen();
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
