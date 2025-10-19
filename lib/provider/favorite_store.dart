// favorite_store.dart
import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../models/plant.dart';
import '../model/modelo_ecossistema.dart';
import '../services/animal_service.dart';
import '../services/plant_service.dart';
import '../services/servico_ecossistema.dart';

class FavoriteStore extends ChangeNotifier {
  final List<Animal> _animalFavorites = [];
  final List<Plant> _plantFavorites = [];
  final List<Ecossistema> _ecosystemFavorites = [];

  void toggleFavorite(dynamic item) {
    if (item is Animal) {
      item.isFavorite = !item.isFavorite;
      AnimalService.toggleFavorite(item);
      item.isFavorite
          ? _animalFavorites.add(item)
          : _animalFavorites.removeWhere((a) => a.id == item.id);
    } else if (item is Plant) {
      item.isFavorite = !item.isFavorite;
      PlantService.toggleFavorite(item);
      item.isFavorite
          ? _plantFavorites.add(item)
          : _plantFavorites.removeWhere((p) => p.id == item.id);
    } else if (item is Ecossistema) {
      item.favorito = !item.favorito;
      ServicoEcossistema.toggleFavorito(item);
      item.favorito
          ? _ecosystemFavorites.add(item)
          : _ecosystemFavorites.removeWhere((e) => e.id == item.id);
    }
    notifyListeners();
  }

  Map<String, List<dynamic>> getFavoritesByType() {
    return {
      'Animais': _animalFavorites,
      'Plantas': _plantFavorites,
      'Ecossistemas': _ecosystemFavorites,
    };
  }
}
