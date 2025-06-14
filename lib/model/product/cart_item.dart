class CartItem {
  int? id;
  String? userId;
  List<Items>? items;
  int? deliveryMethodId;
  int? paymentIntentId;
  String? clientSecret;
  num? totalPrice;

  CartItem(
      {this.id,
        this.userId,
        this.items,
        this.deliveryMethodId,
        this.paymentIntentId,
        this.clientSecret,
        this.totalPrice});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    deliveryMethodId = json['deliveryMethodId'];
    paymentIntentId = json['paymentIntentId'];
    clientSecret = json['clientSecret'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['deliveryMethodId'] = this.deliveryMethodId;
    data['paymentIntentId'] = this.paymentIntentId;
    data['clientSecret'] = this.clientSecret;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
  @override
  String toString() {
    return 'CartItem{id: $id, userId: $userId, items: $items, deliveryMethodId: $deliveryMethodId, paymentIntentId: $paymentIntentId, clientSecret: $clientSecret, totalPrice: $totalPrice}';
  }
}

class Items {
  int? productId;
  String? productName;
  String? pictureUrl;
  String? type;
  double? price;
  int? quantity;

  Items(
      {this.productId,
        this.productName,
        this.pictureUrl,
        this.type,
        this.price,
        this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    pictureUrl = json['pictureUrl'];
    type = json['type'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['pictureUrl'] = this.pictureUrl;
    data['type'] = this.type;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
  @override
  String toString() {
    return 'Items{productId: $productId, productName: $productName, pictureUrl: $pictureUrl, type: $type, price: $price, quantity: $quantity}';
  }
}