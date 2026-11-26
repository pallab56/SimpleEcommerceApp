class CategoryConstants {
  const CategoryConstants._();

  // API Pagination
  static const int defaultPage = 1;
  static const int defaultCategoriesPageSize = 10;
  static const int defaultProductsPageSize = 20;

  // Scroll & Grid Layout
  static const double scrollLoadThreshold = 200.0;
  static const double screenPadding = 16.0;

  static const int categoryGridColumns = 4;
  static const double categoryMainAxisSpacing = 16.0;
  static const double categoryCrossAxisSpacing = 8.0;
  static const double categoryChildAspectRatio = 0.78;

  static const int productGridColumns = 2;
  static const double productGridSpacing = 12.0;
  static const double productChildAspectRatio = 0.72;
}
