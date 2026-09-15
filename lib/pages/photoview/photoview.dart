import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  const PhotoViewPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PhotoViewPage());
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final url = arguments is Map ? arguments['url'] as String? : null;
    final title = arguments is Map ? arguments['title'] as String? : null;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text((title ?? '').isEmpty ? 'View image'.tr() : title!,
            style: const TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: (url ?? '').isEmpty
            ? _error()
            : PhotoView(
                imageProvider: CachedNetworkImageProvider(url!),
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 5,
                loadingBuilder: (context, progress) => const Center(
                    child: CircularProgressIndicator(color: Colors.white)),
                errorBuilder: (context, error, stackTrace) => _error(),
              ),
      ),
    );
  }

  Widget _error() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.broken_image_outlined,
                color: Colors.white70, size: 48),
            const SizedBox(height: 12),
            Text('Unable to load image'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70)),
          ],
        ),
      );
}
