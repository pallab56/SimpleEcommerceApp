import '../../../../core/common/entities/product.dart';

class ProductDetails extends Product {
  final String description;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final int availableQuantity;

  const ProductDetails({
    required super.id,
    required super.title,
    required super.price,
    required super.rating,
    required super.imageUrl,
    required super.categoryId,
    required this.description,
    required this.photos,
    required this.colors,
    required this.sizes,
    required this.availableQuantity,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        description,
        photos,
        colors,
        sizes,
        availableQuantity,
      ];
}
