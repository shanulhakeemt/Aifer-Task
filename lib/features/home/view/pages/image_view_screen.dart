import 'package:aifer_task/core/models/image_model.dart';
import 'package:aifer_task/core/variables/variables.dart';
import 'package:aifer_task/core/widgets/loader.dart';
import 'package:aifer_task/features/home/view/widgets/custom_button.dart';
import 'package:aifer_task/features/home/viewmodel/home_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageViewScreen extends ConsumerWidget {
  const ImageViewScreen({super.key, required this.url});
  final UrlTypeModel url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Image',
          style: GoogleFonts.roboto(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .06, vertical: h * .02),
        child: Column(
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: url.regular,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: Loader(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )),
            SizedBox(
              height: h * .02,
            ),
            GestureDetector(
              onTap: () {
                ref
                    .read(homeViewModelProvider.notifier)
                    .downloadImageToStorage(url.full, context);
              },
              child: Consumer(builder: (context, ref, child) {
                final isLoading = ref.watch(homeViewModelProvider).isLoading;
                return isLoading
                    ? SizedBox(height: h * .1, child: const Loader())
                    : CustomButton(
                        height: h * .09,
                        text: 'Download',
                        textSize: w * .07,
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}
