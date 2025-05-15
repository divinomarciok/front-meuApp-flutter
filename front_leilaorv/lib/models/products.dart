class Product {
  final int id;
  final String name;
  final String? unidade_measure;
  final String mark;
  final int? category; // Mantemos como int
  final String? img_url;
  final double? weigth;
  final String? description;
  final bool isSale;  
  

  Product({
    required this.id,
    required this.name,
    this.unidade_measure,
    required this.mark,
    this.category,
    this.img_url,
    this.weigth,
    this.description,
    this.isSale=false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Extrair o ID da categoria do objeto category
    int? categoryId;
    if (json['category'] is Map) {
      // Se category é um objeto, pegamos o ID dele
      categoryId = json['category']['id'];
    } else {
      // Se category já é um ID (int), usamos diretamente
      categoryId = json['category'];
    }

    return Product(
      id: json['id'],
      name: json['name'],
      unidade_measure: json['unidade_measure'],
      mark: json['mark'],
      category: categoryId,
      img_url: json['img_url'],
      weigth:
          json['weigth'] != null
              ? double.parse(json['weigth'].toString())
              : null,
      isSale: json['isSale'] == true,
      description: json['description'],
    );
  }
}
