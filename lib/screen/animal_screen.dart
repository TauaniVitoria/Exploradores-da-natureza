// TELA QUE EXIBE OS CARDS DOS ANIMAIS
import 'package:flutter/material.dart';
import '../card/animal_card.dart';
import '../models/animal.dart';
import '../services/animal_service.dart';
import 'screen-favorite.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  List<Animal> animals = [];

  @override
  void initState() {
    super.initState();
    _loadAnimals();
  }

  Future<void> _loadAnimals() async {
    final loadedAnimals = await AnimalService.getAllAnimals();
    setState(() {
      animals = loadedAnimals;
    });
  }

  // Função para agrupar os animais por categoria
  Map<String, List<Animal>> _groupAnimalsByCategory() {
    Map<String, List<Animal>> groupedAnimals = {};
    for (var animal in animals) {
      if (groupedAnimals.containsKey(animal.category)) {
        groupedAnimals[animal.category]?.add(animal);
      } else {
        groupedAnimals[animal.category] = [animal];
      }
    }
    return groupedAnimals;
  }

  void _showCategoryDetails(
    BuildContext context,
    String category,
    List<Animal> animals,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.9,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            builder:
                (_, controller) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getCategoryDescription(category),
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: animals.length,
                          itemBuilder: (context, index) {
                            return AnimalCard(animal: animals[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Animal>> groupedAnimals = _groupAnimalsByCategory();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 121, 88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Trilha dos Animais',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Cabeçalho que agora rola junto
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Catálogo de Animais!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Explore nossa coleção de animais organizada por categorias. Toque em qualquer card para ver detalhes ou no botão "Ver mais" para explorar animais adicionais de cada grupo.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),

                  // Lista de categorias
                  ...groupedAnimals.keys.map((category) {
                    List<Animal> categoryAnimals = groupedAnimals[category]!;
                    List<Animal> displayedAnimals =
                      categoryAnimals.length > 3
                        ? categoryAnimals.sublist(0, 3)
                        : categoryAnimals;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            '${category[0].toUpperCase()}${category.substring(1).toLowerCase()}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        Text(
                          _getCategoryDescription(category),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: displayedAnimals.length,
                          itemBuilder: (context, index) {
                            return AnimalCard(animal: displayedAnimals[index]);
                          },
                        ),
                        // Botao Ver mais
                        if (categoryAnimals.length > 3)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: const Color.fromARGB(
                                  255,
                                  7,
                                  141,
                                  110,
                                ),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                _showCategoryDetails(
                                  context,
                                  '${category[0].toUpperCase()}${category.substring(1).toLowerCase()}',
                                  categoryAnimals,//
                                );
                              },
                              child: const Text(
                                'Ver mais',
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Função para obter descrições das categorias
String _getCategoryDescription(String category) {
 final descriptions = {
    'anfibios': 'Vertebrados que passam parte da vida na água e parte em terra, geralmente com pele permeável e respiração cutânea.',
    'artropodes': 'Invertebrados com exoesqueleto, corpo segmentado e apêndices articulados, incluindo insetos, aracnídeos, crustáceos e outros.',
    'aves': 'Vertebrados de sangue quente, com penas, bico sem dentes e, na maioria das espécies, capacidade de voo.',
    'mamiferos': 'Vertebrados de sangue quente que possuem glândulas mamárias e pelos em algum estágio da vida.',
    'moluscos': 'Invertebrados de corpo mole, muitas vezes protegidos por concha, como caracóis, polvos e mexilhões.',
    'peixes': 'Vertebrados aquáticos com brânquias, nadadeiras e corpo geralmente coberto por escamas.',
    'repteis': 'Vertebrados de sangue frio com corpo coberto por escamas queratinizadas, adaptados à vida terrestre.',
  };

  return descriptions[category.toLowerCase()] ??
      'Descrição da categoria $category';
}
