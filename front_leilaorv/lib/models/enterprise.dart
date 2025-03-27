class Enterprise {
  final int id;
  final String name;
  final String addres;
  final String cep;
  final String cnpj;

  Enterprise({
    required this.id,
    required this.name,
    required this.addres,
    required this.cep,
    required this.cnpj,
  });

  factory Enterprise.fromJson(Map<String, dynamic> json) {
    return Enterprise(
      id: json['id'],
      name: json['name'],
      addres: json['addres'],
      cep: json['cep'],
      cnpj: json['cnpj'],
    );
  }
}
