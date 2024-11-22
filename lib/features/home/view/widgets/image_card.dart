import 'package:aifer_task/core/models/image_model.dart';
import 'package:aifer_task/core/utils.dart';
import 'package:aifer_task/core/widgets/loader.dart';
import 'package:aifer_task/features/home/view/pages/image_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.url,
  });

  final UrlTypeModel url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return ImageViewScreen(
                    url: url,
                  );
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final tween = Tween(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeIn));

                  final offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: url.small,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: Loader(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ));
  }
}
