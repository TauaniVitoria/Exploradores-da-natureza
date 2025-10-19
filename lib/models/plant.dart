class Plant {
  final int id;
  final String commonName;
  final String scientificName;
  final String imageAsset;
  final String imageAsset2;
  final String habitat;
  final String lifeCycle;
  final String ecologicalImportance;
  final String humanUses;
  final String conservationStatus;
  final List<String> curiosities;
  bool isFavorite;

  Plant({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.imageAsset,
    required this.imageAsset2,
    required this.habitat,
    required this.lifeCycle,
    required this.ecologicalImportance,
    required this.humanUses,
    required this.conservationStatus,
    required this.curiosities,
    this.isFavorite = false,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      commonName: json['commonName'],
      scientificName: json['scientificName'],
      imageAsset: json['imageAsset'],
      imageAsset2: json['imageAsset2'],
      habitat: json['habitat'],
      lifeCycle: json['lifeCycle'],
      ecologicalImportance: json['ecologicalImportance'],
      humanUses: json['humanUses'],
      conservationStatus: json['conservationStatus'],
      curiosities: List<String>.from(json['curiosities']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'commonName': commonName,
      'scientificName': scientificName,
      'imageAsset': imageAsset,
      'imageAsset2': imageAsset2,
      'habitat': habitat,
      'lifeCycle': lifeCycle,
      'ecologicalImportance': ecologicalImportance,
      'humanUses': humanUses,
      'conservationStatus': conservationStatus,
      'curiosities': curiosities,
      'isFavorite': isFavorite,
    };
  }
}

// Enum para os estados de conservação
enum PlantConservationStatus {
  extinct,
  extinctInTheWild,
  criticallyEndangered,
  endangered,
  vulnerable,
  nearThreatened,
  leastConcern,
  dataDeficient,
  notEvaluated,
}

// Extensão para obter a descrição em português dos estados de conservação
extension PlantConservationStatusExtension on PlantConservationStatus {
  String get description {
    switch (this) {
      case PlantConservationStatus.extinct:
        return 'Extinta';
      case PlantConservationStatus.extinctInTheWild:
        return 'Extinta na Natureza';
      case PlantConservationStatus.criticallyEndangered:
        return 'Criticamente Ameaçada';
      case PlantConservationStatus.endangered:
        return 'Ameaçada';
      case PlantConservationStatus.vulnerable:
        return 'Vulnerável';
      case PlantConservationStatus.nearThreatened:
        return 'Quase Ameaçada';
      case PlantConservationStatus.leastConcern:
        return 'Pouco Preocupante';
      case PlantConservationStatus.dataDeficient:
        return 'Dados Insuficientes';
      case PlantConservationStatus.notEvaluated:
        return 'Não Avaliada';
    }
  }
}
