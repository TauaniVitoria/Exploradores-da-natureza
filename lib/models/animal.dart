class Animal {
  final int id;
  final String category;
  final String commonName;
  final String scientificName;
  final String habitat;
  final String geographicDistribution;
  final String feeding;
  final String behavior;
  final String ecologicalNiche;
  final String conservationStatus;
  final List<String> curiosities;
  final String imageAsset;
  final String imageAsset2;
  bool isFavorite;

  Animal({
    required this.id,
    required this.category,
    required this.commonName,
    required this.scientificName,
    required this.habitat,
    required this.geographicDistribution,
    required this.feeding,
    required this.behavior,
    required this.ecologicalNiche,
    required this.conservationStatus,
    required this.curiosities,
    required this.imageAsset,
    required this.imageAsset2,
    this.isFavorite = false,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      category: json['category'],
      commonName: json['commonName'],
      scientificName: json['scientificName'],
      habitat: json['habitat'],
      geographicDistribution: json['geographicDistribution'],
      feeding: json['feeding'],
      behavior: json['behavior'],
      ecologicalNiche: json['ecologicalNiche'],
      conservationStatus: json['conservationStatus'],
      curiosities: List<String>.from(json['curiosities']),
      imageAsset: json['imageAsset'],
      imageAsset2: json['imageAsset2'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Método para criar um Animal a partir de um Map (útil para JSON)
  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      id: map['id'] ?? 0,
      category: map['category'] ?? '',
      commonName: map['commonName'] ?? '',
      scientificName: map['scientificName'] ?? '',
      habitat: map['habitat'] ?? '',
      geographicDistribution: map['geographicDistribution'] ?? '',
      feeding: map['feeding'] ?? '',
      behavior: map['behavior'] ?? '',
      ecologicalNiche: map['ecologicalNiche'] ?? '',
      conservationStatus: map['conservationStatus'] ?? '',
      curiosities: List<String>.from(map['curiosities'] ?? []),
      imageAsset: map['imageAsset'] ?? '',
      imageAsset2: map['imageAsset2'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  // Método para converter o Animal em um Map (útil para JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'commonName': commonName,
      'scientificName': scientificName,
      'habitat': habitat,
      'geographicDistribution': geographicDistribution,
      'feeding': feeding,
      'behavior': behavior,
      'ecologicalNiche': ecologicalNiche,
      'conservationStatus': conservationStatus,
      'curiosities': curiosities,
      'imageAsset': imageAsset,
      'imageAsset2': imageAsset2,
      'isFavorite': isFavorite,
    };
  }
}

// Enum para os estados de conservação
enum EstadoConservacao {
  extinto,
  extintoNatureza,
  criticamenteAmeacado,
  ameacado,
  vulneravel,
  quaseAmeacado,
  poucoPreocupante,
  dadosInsuficientes,
  naoAvaliado,
}

// Enum para tipos de alimentação
enum TipoAlimentacao { herbivoro, carnivoro, onivoro, detritivoro, filtrador }

// Extensão para obter a descrição em português dos estados de conservação
extension EstadoConservacaoExtension on EstadoConservacao {
  String get descricao {
    switch (this) {
      case EstadoConservacao.extinto:
        return 'Extinto';
      case EstadoConservacao.extintoNatureza:
        return 'Extinto na Natureza';
      case EstadoConservacao.criticamenteAmeacado:
        return 'Criticamente Ameaçado';
      case EstadoConservacao.ameacado:
        return 'Ameaçado';
      case EstadoConservacao.vulneravel:
        return 'Vulnerável';
      case EstadoConservacao.quaseAmeacado:
        return 'Quase Ameaçado';
      case EstadoConservacao.poucoPreocupante:
        return 'Pouco Preocupante';
      case EstadoConservacao.dadosInsuficientes:
        return 'Dados Insuficientes';
      case EstadoConservacao.naoAvaliado:
        return 'Não Avaliado';
    }
  }
}

// Extensão para obter a descrição em português dos tipos de alimentação
extension TipoAlimentacaoExtension on TipoAlimentacao {
  String get descricao {
    switch (this) {
      case TipoAlimentacao.herbivoro:
        return 'Herbívoro';
      case TipoAlimentacao.carnivoro:
        return 'Carnívoro';
      case TipoAlimentacao.onivoro:
        return 'Onívoro';
      case TipoAlimentacao.detritivoro:
        return 'Detritívoro';
      case TipoAlimentacao.filtrador:
        return 'Filtrador';
    }
  }
}
