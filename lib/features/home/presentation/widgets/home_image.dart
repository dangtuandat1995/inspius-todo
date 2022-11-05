import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/lorem_image_info.dart';

class HomeImage extends StatelessWidget {
  final LoremImageInfo imageInfo;
  const HomeImage({Key? key, required this.imageInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 200,
          child: CachedNetworkImage(
            alignment: Alignment.center,
            fit: BoxFit.contain,
            imageUrl: imageInfo.downloadUrl,
            placeholder: (_, __) {
              return const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            },
            errorWidget: (context, url, error) => const Placeholder(),
          ),
        ),
        Positioned(
          bottom: 10,
          child: Text(
            imageInfo.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 2)],
            ),
          ),
        ),
      ],
    );
  }
}
