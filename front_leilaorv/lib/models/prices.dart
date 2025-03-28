class Price {
  final int id;
  final product_id;
  final enterprise_id;
  final double price;
  final bool is_sale;
  final date_start;

  Price({
    required this.id,
    required this.product_id,
    required this.enterprise_id,
    required this.price,
    required this.is_sale,
    required this.date_start,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'],
      product_id: json['product_id'],
      enterprise_id: json['enterprise_id'],
      price: json['price'],
      is_sale: json['is_sale'],
      date_start: json['date_start'],
    );
  }
}
