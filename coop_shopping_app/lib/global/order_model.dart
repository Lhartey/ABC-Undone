class MyOrder {
  final String orderId;
  final String productName;
  final double price;

  MyOrder({
    required this.orderId,
    required this.productName,
    required this.price,
  });

  factory MyOrder.fromMap(Map<String, dynamic> map) {
    return MyOrder(
      orderId: map['orderId'] as String,
      productName: map['productName'] as String,
      price: map['price'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'productName': productName,
      'price': price,
    };
  }
}
