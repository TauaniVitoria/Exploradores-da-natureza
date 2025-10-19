class Ecosystem {
  final int id;
  final String tipo;
  final String nome;
  final String imagem;
  final String imagem2;
  final String descricao;
  final String localizacao;
  final String clima;
  final String fauna;
  final String flora;
  final String curiosidades;

  Ecosystem({
    required this.id,
    required this.tipo,
    required this.nome,
    required this.imagem,
    required this.imagem2,
    required this.descricao,
    required this.localizacao,
    required this.clima,
    required this.fauna,
    required this.flora,
    required this.curiosidades,
  });

  factory Ecosystem.fromJson(Map<String, dynamic> json) {
    return Ecosystem(
      id: json['id'],
      tipo: json['tipo'],
      nome: json['nome'],
      imagem: json['imagem'],
      imagem2: json['imagem2'],
      descricao: json['descricao'],
      localizacao: json['localizacao'],
      clima: json['clima'],
      fauna: json['fauna'],
      flora: json['flora'],
      curiosidades: json['curiosidades'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'nome': nome,
      'imagem': imagem,
      'imagem2': imagem2,
      'descricao': descricao,
      'localizacao': localizacao,
      'clima': clima,
      'fauna': fauna,
      'flora': flora,
      'curiosidades': curiosidades,
    };
  }
}
