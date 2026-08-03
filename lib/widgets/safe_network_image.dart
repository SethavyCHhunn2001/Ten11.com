import 'package:flutter/material.dart';

class SafeNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const SafeNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: Colors.pink.shade50,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: Colors.pink.shade200,
        size: 32,
      ),
    );

    Widget image = Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          child: const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => placeholder,
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}

// Decoration-image variant for containers that used
// `image: DecorationImage(image: NetworkImage(...))`. Falls back to a
// solid tinted background (no crash / no broken-image icon) if the
// network request fails, and never throws unhandled exceptions.
BoxDecoration safeNetworkDecoration(
  String url, {
  BorderRadius? borderRadius,
  Gradient? gradient,
}) {
  return BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: borderRadius,
    gradient: gradient,
    image: DecorationImage(
      image: NetworkImage(url),
      fit: BoxFit.cover,
      onError: (exception, stackTrace) {
        // Swallow network/handshake errors so they don't spam the
        // console or crash the frame; the grey background above
        // shows through as a graceful fallback.
      },
    ),
  );
}
