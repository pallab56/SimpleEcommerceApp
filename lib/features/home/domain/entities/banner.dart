// Banner entity — imageUrl, targetRoute.
import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String? productId;
  final String? categoryId;

  const BannerEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.productId,
    this.categoryId,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, productId, categoryId];
}
