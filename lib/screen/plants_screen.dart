import 'package:flutter/material.dart';
import '../card/plant_card.dart';
import '../models/plant.dart';
import '../services/plant_service.dart';
import 'screen-favorite.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  List<Plant> plants = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    if (mounted) {
      setState(() {
        isLoading = true;
        error = null;
      });
    }

    try {
      final loadedPlants = await PlantService.getAllPlants();

      if (mounted) {
        setState(() {
          plants = loadedPlants;
          isLoading = false;
          error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = 'Não foi possível carregar as plantas. Tente novamente.';
          isLoading = false;
        });
      }
    }
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(
            error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadPlants,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 141, 110),
            ),
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color.fromARGB(255, 7, 141, 110)),
          SizedBox(height: 16),
          Text(
            'Carregando plantas...',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 7, 141, 110),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: _loadPlants,
      color: const Color.fromARGB(255, 7, 141, 110),
      child: ListView(
        children: [
          // Cabeçalho
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bem-vindo ao Catálogo de Plantas!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 141, 110),
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

          // Lista de plantas
          if (plants.isEmpty && !isLoading && error == null)
            const Center(
              child: Text(
                'Nenhuma planta encontrada',
                style: TextStyle(fontSize: 16),
              ),
            )
          else
            ...plants.map((plant) => PlantCard(plant: plant)).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
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
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child:
            isLoading
                ? _buildLoadingWidget()
                : error != null
                ? _buildErrorWidget()
                : _buildContent(),
      ),
    );
  }
}
