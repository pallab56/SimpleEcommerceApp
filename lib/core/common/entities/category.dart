import 'package:equatable/equatable.dart';

/// Shared Category entity — used in Home and Category features.
class Category extends Equatable {
  final String id;
  final String name;
  final String iconUrl; // could be a local asset or network URL

  const Category({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [id, name, iconUrl];
}
