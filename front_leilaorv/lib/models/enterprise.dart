class Enterprise {
  final int id;
  final String name;
  final String address;
  final String cep;
  final String cnpj;

  Enterprise({
    required this.id,
    required this.name,
    required this.address,
    required this.cep,
    required this.cnpj,
  });

  factory Enterprise.fromJson(Map<String, dynamic> json) {
    return Enterprise(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      cep: json['cep'],
      cnpj: json['cnpj'],
    );
  }
}
