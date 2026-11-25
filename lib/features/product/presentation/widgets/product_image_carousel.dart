import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';

/// Auto-scrolling image slider with dot indicators (Product Details top section).
class ProductImageCarousel extends StatefulWidget {
  /// Pass the same [imageAsset] path multiple times if only one image exists yet.
  final int imageCount;

  const ProductImageCarousel({super.key, this.imageCount = 3});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.imageCount,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => Image.asset(
              AppAssets.shoe,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imageCount,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _current == i ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _current == i ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
