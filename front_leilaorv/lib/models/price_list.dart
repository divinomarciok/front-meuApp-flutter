class PriceList {
  final String nameProd;
  final String mark;
  final String price;
  final bool? isSale;
  final String enterprise;
  final String un;
  final String? weigth;
  final String img_url;

  PriceList({
    required this.nameProd,
    required this.mark,
    required this.price,
    this.isSale,
    required this.enterprise,
    required this.un,
    this.weigth,
    required this.img_url,
  });

  factory PriceList.fromJson(Map<String, dynamic> json) {
    return PriceList(
      nameProd: json['nameProd'],
      mark: json['mark'],
      price: json['price'],
      isSale: json['isSale'],
      enterprise: json['enterprise'],
      un: json['un'],
      weigth: json['weigth'],
      img_url: json['img_url'],
    );
  }
}
