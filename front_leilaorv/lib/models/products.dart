class Product {
  final String id;
  final String nome;
  final String? tamanho;
  final String marca;
  final int categoria;
  final String? img_url;

  Product({
    required this.id,
    required this.nome,
    this.tamanho,
    required this.marca,
    required this.categoria,
    this.img_url,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nome: json['nome'],
      tamanho: json['tamanho'],
      marca: json['marca'],
      categoria: json['categoria'],
      img_url: json['img_url'],
    );
  }
  // final String id;
  // final String name;
  // final String? description;
  // final double price;
  // final String category_id;
  // final String? codigo_barras;
  // final String mark_id;
  // final String? image_url;
  //
  // Product({
  //   required this.id,
  //   required this.name,
  //   this.description,
  //   required this.price,
  //   required this.category_id,
  //   this.codigo_barras,
  //   required this.mark_id,
  //   this.image_url,
  // });
  //
  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     id: json['id'],
  //     name: json['name'],
  //     description: json['description'],
  //     price: json['price'],
  //     category_id: json['category_id'],
  //     codigo_barras: json['codigo_barras'],
  //     mark_id: json['mark_id'],
  //     image_url: json['image_url'],
  //   );
  // }
}
