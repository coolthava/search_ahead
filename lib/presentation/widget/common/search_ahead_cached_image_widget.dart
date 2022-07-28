import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:search_ahead/core/common/extensions/container_modifier.dart';
import 'package:shimmer/shimmer.dart';

class SearchAheadCachedImage extends StatefulWidget {
  final String? imageUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final Widget Function(ImageProvider imageProvider)? imageBuilder;
  final Clip clipBehaviour;
  final Color? color;
  final VoidCallback? onLoadFailed;

  const SearchAheadCachedImage(this.imageUrl,
      {Key? key,
      this.placeholder,
      this.errorWidget,
      this.width,
      this.height,
      this.fit,
      this.alignment = Alignment.center,
      this.imageBuilder,
      this.clipBehaviour = Clip.none,
      this.color,
      this.onLoadFailed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchAheadCachedImageWidgetState();
}

class _SearchAheadCachedImageWidgetState extends State<SearchAheadCachedImage> {
  @override
  Widget build(BuildContext context) {
    if ((_isImageNotNullAndEmpty())) {
      return ExtendedImage.network(
        widget.imageUrl!,
        fit: widget.fit,
        filterQuality: FilterQuality.none,
        width: widget.width,
        height: widget.height,
        clipBehavior: widget.clipBehaviour,
        alignment: widget.alignment,
        loadStateChanged: _handleStateChange,
        cacheMaxAge: const Duration(days: 1),
      );
    }
    return const SizedBox.shrink();
  }

  bool _isImageNotNullAndEmpty() {
    return widget.imageUrl != null &&
        widget.imageUrl!.isNotEmpty &&
        !widget.imageUrl!.contains('null');
  }

  Widget _handleStateChange(ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        if (widget.placeholder != null) {
          return widget.placeholder!;
        } else {
          return Shimmer.fromColors(
              child: Container().applyShimmerDecoration(),
              baseColor: const Color.fromRGBO(216, 216, 216, 1),
              highlightColor: const Color.fromRGBO(248, 248, 248, 1));
        }
      case LoadState.completed:
        if (widget.imageBuilder != null) {
          return widget.imageBuilder!.call(state.imageProvider);
        } else {
          return state.completedWidget;
        }
      case LoadState.failed:
        widget.onLoadFailed?.call();
        return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return widget.errorWidget ?? const Icon(Icons.error);
  }
}
