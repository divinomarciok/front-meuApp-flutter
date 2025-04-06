class Product {
  final String id;
  final String nome;
  final String? tamanho;
  final String marca;
  final int categoria;
  final String img_url ;

  Product({
    required this.id,
    required this.nome,
    this.tamanho,
    required this.marca,
    required this.categoria,
    required this.img_url ,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nome: json['nome'],
      tamanho: json['tamanho'],
      marca: json['marca'],
      categoria: json['categoria'],
      img_url : json['img_url'],
    );
  }
}
