class EndPoints {
  static const String baseUrl = 'https://naptaapi.runasp.net/api/';
  static const String login = 'Account/Login';
  static const String profile = 'Account/GetCurrentUser';
  static const String register = 'Account/Register';
  static const String getAddress = 'Account/GetUserAddress';
  static const String addAddress = 'Account/AddUserAddress';
  static const String uploadUserPicture = 'Account/upload-user-picture';
  static const String products = 'Product/GetAllProducts';
  static const String categories = 'Product/types';
  static const String addToCart = 'Basket/add-item';
  static const String getCart = 'Basket/Get_Basket';
  static const String clearCart = 'Basket/Clear_Basket';
  static const String removeFromCart = 'Basket/remove-item';
  static const String increaseQuantity = 'Basket/IncreaseItemQuantity';
  static const String decreaseQuantity = 'Basket/DecreaseItemQuantity';
  static const String createOrder = 'Orders/Create_Order';
  static const String getOrders = 'Orders/GetAllOrderForSpecificUser';
  static const String toggleFavorite = 'Favorites/ToggleFavorite';
  static const String getFavorites = 'Favorites/Get_Favorites';
}
