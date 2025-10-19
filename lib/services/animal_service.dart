import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/animal.dart';

class AnimalService {
  static List<Animal>? _cachedAnimals;
  static final Set<int> _favoritedIds = {};

  static Future<List<Animal>> getAllAnimals() async {
    if (_cachedAnimals != null) {
      // Atualiza o estado dos favoritos antes de retornar
      for (var animal in _cachedAnimals!) {
        animal.isFavorite = _favoritedIds.contains(animal.id);
      }
      return _cachedAnimals!;
    }

    try {
      // Carrega o arquivo JSON
      final String jsonString = await rootBundle.loadString(
        'assets/data/animals.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Converte os dados em uma lista de animais
      final List<dynamic> animalList = jsonData['animals'];
      _cachedAnimals =
          animalList.map((json) {
            final animal = Animal.fromJson(json);
            animal.isFavorite = _favoritedIds.contains(animal.id);
            return animal;
          }).toList();
      return _cachedAnimals!;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Animal>> getAnimalsByCategory(String category) async {
    final animals = await getAllAnimals();
    return animals.where((animal) => animal.category == category).toList();
  }

  static Future<Animal?> getAnimalById(int id) async {
    final animals = await getAllAnimals();
    try {
      return animals.firstWhere((animal) => animal.id == id);
    } catch (e) {
      return null;
    }
  }

  static void toggleFavorite(Animal animal) {
    if (animal.isFavorite) {
      _favoritedIds.add(animal.id);
    } else {
      _favoritedIds.remove(animal.id);
    }
  }

  static List<String> getAllCategories() {
    return [
      'anfibios',
      'aves',
      'artropodes',
      'mamiferos',
      'repteis',
      'moluscos',
      'peixes',
    ];
  }

  static Map<String, String> getCategoryNames() {
    return {
      'anfibios': 'Anfíbios',
      'aves': 'Aves',
      'artropodes': 'Artrópodes',
      'mamiferos': 'Mamíferos',
      'repteis': 'Répteis',
      'moluscos': 'Moluscos',
      'peixes': 'Peixes',
    };
  }
}
