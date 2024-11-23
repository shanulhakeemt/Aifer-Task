import 'package:aifer_task/core/theme/app_pallete.dart';
import 'package:aifer_task/features/category/view/pages/category_screen.dart';
import 'package:aifer_task/features/home/view/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navIndexProvider = StateProvider(
  (ref) => 0,
);

class NavScreen extends ConsumerWidget {
  const NavScreen({super.key});
  static const navBarItems = [
    {'label': 'Home', 'icon': CupertinoIcons.home},
    {'label': 'Search', 'icon': CupertinoIcons.search},
    {'label': 'Category', 'icon': CupertinoIcons.folder},
  ];
  final screens = const [
    HomeScreen(),
    Scaffold(
      backgroundColor: Pallete.secondoryColor,
    ),
    CategoryScreen(),
  ];

  updateNavIndex(int index, WidgetRef ref) {
    ref.read(navIndexProvider.notifier).update(
          (state) => index,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: screens[ref.watch(navIndexProvider)], // Show the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(navIndexProvider),
        onTap: (value) => updateNavIndex(value, ref),
        items: List.generate(
          navBarItems.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(navBarItems[index]['icon'] as IconData),
            label: navBarItems[index]['label'] as String,
          ),
        ),
      ),
    );
  }
}
