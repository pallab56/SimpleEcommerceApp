import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> photos;

  const ProductImageCarousel({
    super.key,
    required this.photos,
  });

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.photos.isNotEmpty ? widget.photos.length : 1;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            itemCount: itemCount,
            onPageChanged: (index) => setState(() => _activeIndex = index),
            itemBuilder: (_, index) {
              final url = widget.photos.isNotEmpty ? widget.photos[index] : '';
              return ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: url.startsWith('http')
                    ? Image.network(
                        url,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          AppAssets.shoe,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        AppAssets.shoe,
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
        ),
        if (widget.photos.length > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.photos.length, (index) {
                final isActive = index == _activeIndex;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isActive ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.white70,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
