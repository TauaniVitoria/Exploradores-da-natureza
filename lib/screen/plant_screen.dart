import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../card/plant_card.dart';
import '../services/plant_service.dart';
import 'screen-favorite.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  List<Plant> plants = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    try {
      final loadedPlants = await PlantService.getAllPlants();
      setState(() {
        plants = loadedPlants;
        isLoading = false;
        error = null;
      });
    } catch (e) {
      setState(() {
        error = 'Erro ao carregar as plantas: $e';
        isLoading = false;
      });
    }
  }

  void _showCategoryDetails(
    BuildContext context,
    String category,
    List<Plant> plants,
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
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: plants.length,
                          itemBuilder: (context, index) {
                            return PlantCard(plant: plants[index]);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 121, 88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Trilha dos Plantas',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.red,
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
      body: RefreshIndicator(
        onRefresh: _loadPlants,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Catálogo de Plantas',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Explore nossa coleção de plantas nativas do Brasil. Descubra suas características, importância ecológica e curiosidades.',
                          style: TextStyle(fontSize: 16, height: 1.4),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                    // Indicador de carregamento ou erro
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 7, 141, 110),
                          ),
                        ),
                      )
                    else if (error != null)
                      Center(
                        child: Column(
                          children: [
                            Text(
                              error!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadPlants,
                              child: const Text('Tentar novamente'),
                            ),
                          ],
                        ),
                      )
                    else if (plants.isEmpty)
                      const Center(
                        child: Text(
                          'Nenhuma planta encontrada',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    else
                      // Lista de plantas
                      ...plants.map((plant) {
                        return PlantCard(plant: plant);
                      }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
