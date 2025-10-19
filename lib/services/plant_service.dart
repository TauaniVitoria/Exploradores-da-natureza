import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/plant.dart';

class PlantService {
  static List<Plant>? _cachedPlants;
  static final Set<int> _favoritedIds = {};

  static Future<List<Plant>> getAllPlants() async {
    try {
      // Tenta carregar o arquivo JSON
      final String jsonString = await rootBundle
          .loadString('assets/data/plants.json')
          .catchError((error) {
            throw Exception('Não foi possível carregar o arquivo plants.json');
          });

      // Tenta fazer o parse do JSON
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      if (!jsonData.containsKey('plants')) {
        throw Exception('JSON inválido: chave "plants" não encontrada');
      }

      // Converte os dados em uma lista de plantas
      final List<dynamic> plantList = jsonData['plants'];

      _cachedPlants =
          plantList.map((json) {
            try {
              final plant = Plant.fromJson(json);
              plant.isFavorite = _favoritedIds.contains(plant.id);
              return plant;
            } catch (e) {
              rethrow;
            }
          }).toList();

      for (var plant in _cachedPlants!) {}

      return _cachedPlants!;
    } catch (e, stackTrace) {
      return [];
    }
  }

  static Future<Plant?> getPlantById(int id) async {
    final plants = await getAllPlants();
    try {
      return plants.firstWhere((plant) => plant.id == id);
    } catch (e) {
      return null;
    }
  }

  static void toggleFavorite(Plant plant) {
    if (plant.isFavorite) {
      _favoritedIds.add(plant.id);
    } else {
      _favoritedIds.remove(plant.id);
    }
  }
}
