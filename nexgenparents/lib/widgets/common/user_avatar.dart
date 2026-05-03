import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.size,
    this.photoUrl,
  });

  final double size;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final imageUrl = photoUrl?.trim();
    final hasAvatar = imageUrl != null && imageUrl.isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: hasAvatar
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox.shrink(),
              errorWidget: (context, url, error) {
                return Icon(
                  Icons.person_rounded,
                  color: Colors.white.withOpacity(0.95),
                  size: size * 0.54,
                );
              },
            )
          : Icon(
              Icons.person_rounded,
              color: Colors.white.withOpacity(0.95),
              size: size * 0.54,
            ),
    );
  }
}
