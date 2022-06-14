class Basket {
  int typeId;
  int productId;
  int count;
  int price;
  String grams;

  Basket({  required this.typeId,
    required this.productId,
    required this.count,
    required this.price,
    required this.grams,
  });
  Map toJson() => {
    'typeId': typeId,
    'productId': productId,
    'grams': grams,
    'count': count,
    'price': price,
  };
}