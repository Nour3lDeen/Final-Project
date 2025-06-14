class ProductModel {
  int? id;
  String? name;
  String? description;
  num? price;
  String? pictureUrl;
  int? typeId;
  String? typeName;
  int? count;
  num? rate;
  List<String>? morePicturesList;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.pictureUrl,
    this.typeId,
    this.typeName,
    this.count,
    this.rate,
    this.morePicturesList,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? json['productId'], // Handle both field names
      name: json['name'] ?? json['productName'],
      description: json['description'],
      price: json['price'],
      pictureUrl: json['pictureUrl'],
      typeId: json['typeId'],
      typeName: json['typeName'],
      count: json['count'],
      rate: json['rate'],
      morePicturesList: json['morePicturesList'] != null
          ? List<String>.from(json['morePicturesList'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'pictureUrl': pictureUrl,
      'typeId': typeId,
      'typeName': typeName,
      'count': count,
      'rate': rate,
      'morePicturesList': morePicturesList,
    };
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, description: $description, price: $price, pictureUrl: $pictureUrl, typeId: $typeId, typeName: $typeName, count: $count, rate: $rate, morePicturesList: $morePicturesList}';
  }
}