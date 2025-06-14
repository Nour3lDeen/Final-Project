class Orders {
  List<Order>? orders;

  Orders({this.orders});

  Orders.fromJson(List<dynamic> json) {
    orders = json.map((order) => Order.fromJson(order)).toList();
  }
}

class Order {
  int? id;
  String? buyerEmail;
  String? phoneNumber;
  DateTime? orderDate;
  int? status;
  ShippingAddress? shippingAddress;
  String? deliveryMethod;
  double? deliveryMethodCost;
  List<OrderItem>? items;
  double? subTotal;
  double? total;
  String? paymentIntentId;

  Order({
    this.id,
    this.buyerEmail,
    this.phoneNumber,
    this.orderDate,
    this.status,
    this.shippingAddress,
    this.deliveryMethod,
    this.deliveryMethodCost,
    this.items,
    this.subTotal,
    this.total,
    this.paymentIntentId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      buyerEmail: json['buyerEmail'],
      phoneNumber: json['phoneNumber'],
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
      deliveryMethod: json['deliveryMethod'],
      deliveryMethodCost: json['deliveryMethodCost'],
      items: List<OrderItem>.from(
          json['items'].map((item) => OrderItem.fromJson(item))),
      subTotal: json['subTotal'],
      total: json['total'],
      paymentIntentId: json['paymentIntentId'],
    );
  }
}

class ShippingAddress {
  String? fName;
  String? lName;
  String? city;
  String? country;
  String? street;

  ShippingAddress({
    this.fName,
    this.lName,
    this.city,
    this.country,
    this.street,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      fName: json['fName'],
      lName: json['lName'],
      city: json['city'],
      country: json['country'],
      street: json['street'],
    );
  }
}

class OrderItem {
  int? productId;
  String? productName;
  String? pictureUrl;
  double? price;
  int? quantity;

  OrderItem({
    this.productId,
    this.productName,
    this.pictureUrl,
    this.price,
    this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      pictureUrl: json['pictureUrl'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}