class ApiUrls {
  // Base URL
  static const String baseUrl = 'https://ecom-rs8e.onrender.com/api';

  // ==================== Auth & User ====================
  static const String login = '$baseUrl/auth/login'; // POST
  static const String signUp = '$baseUrl/auth/signup'; // POST
  static const String verifyOtp = '$baseUrl/auth/verify-otp'; // POST
  static const String sendOtp = '$baseUrl/auth/resend-otp'; // POST
  static const String profile = '$baseUrl/auth/profile'; // GET, PATCH

  // ==================== Brand ====================
  static const String brands = '$baseUrl/brands'; // GET (List)
  static const String createBrand = '$baseUrl/brand'; // POST (Admin)
  static String brandById(String brandId) => '$baseUrl/brands/$brandId'; // GET, PATCH, DELETE

  // ==================== Category ====================
  static const String categories = '$baseUrl/categories'; // GET (List)
  static const String createCategory = '$baseUrl/category'; // POST (Admin)
  static String categoryById(String catId) => '$baseUrl/categories/$catId'; // GET, PATCH, DELETE

  // ==================== Product ====================
  static const String products = '$baseUrl/products'; // GET (List)
  
  static String productDetails(String id) => '$baseUrl/products/id/$id';
  static const String createProduct = '$baseUrl/product'; // POST (Admin)
  static String productBySlug(String slug) => '$baseUrl/products/$slug'; // GET
  // static String productById(String productId) => '$baseUrl/products/id/$productId'; // GET
  static String updateOrDeleteProduct(String productId) => '$baseUrl/products/$productId'; // PATCH, DELETE (Admin)

  // ==================== Product Review ====================
  static const String reviews = '$baseUrl/reviews'; // GET (List - supports ?product=id)
  static const String createReview = '$baseUrl/review'; // POST
  static String reviewById(String reviewId) => '$baseUrl/reviews/$reviewId'; // PATCH, DELETE

  // ==================== Cart & Wishlist ====================
  static const String cart = '$baseUrl/cart'; // GET (List), POST (Add)
  static String cartItem(String id) => '$baseUrl/cart/$id'; // PATCH, DELETE

  static const String wishlist = '$baseUrl/wishlist'; // GET (List), POST (Add)
  static String removeWishlist(String id) => '$baseUrl/wishlist/$id';

  // ==================== Order ====================
  static const String orders = '$baseUrl/orders'; // GET (List)
  static const String createOrder = '$baseUrl/order'; // POST
  static const String orderTransaction = '$baseUrl/orders/transaction'; // POST
  static String orderById(String orderId) => '$baseUrl/orders/$orderId'; // GET, PATCH (Admin), DELETE (Admin)
  static String cancelOrder(String orderId) => '$baseUrl/orders/$orderId/cancel'; // PATCH

  // ==================== Slide ====================
  static const String sliders = '$baseUrl/slides'; // GET (List)
  static const String createSlide = '$baseUrl/slide'; // POST (Admin)
  static String slideById(String slideId) => '$baseUrl/slides/$slideId'; // DELETE (Admin)
}
