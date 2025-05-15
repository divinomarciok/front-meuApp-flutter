import './products.dart'; // Ajuste o caminho do import
import './enterprise.dart'; // Ajuste o caminho do import

class PriceList {
  final int id;
  final bool isSale;
  final String price;
  final String dateStart;
  final Product product;
  final Enterprise enterprise;

  PriceList({
    required this.id,
    required this.isSale,
    required this.price,
    required this.dateStart,
    required this.product,
    required this.enterprise,
  });

  factory PriceList.fromJson(Map<String, dynamic> json) {
    return PriceList(
      id: json['id'],
      isSale: json['isSale'],
      price: json['price'],
      dateStart: json['date_start'],
      product: Product.fromJson(json['product']),
      enterprise: Enterprise.fromJson(json['enterprise']),
    );
  }
}