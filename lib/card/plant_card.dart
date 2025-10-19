import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/plant.dart';
import '../provider/favorite_store.dart';
import '../screen/plant_details_screen.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final favoriteStore = Provider.of<FavoriteStore>(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Color.fromARGB(255, 221, 221, 221),
          width: 1,
        ),
      ),
      shadowColor: Colors.black,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          plant.commonName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plant.scientificName,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PlantDetailsScreen(
                                    plant: {
                                      'nomeComum': plant.commonName,
                                      'nomeCientifico': plant.scientificName,
                                      'imageAsset2': plant.imageAsset2,
                                      'habitat': plant.habitat,
                                      'cicloVida': plant.lifeCycle,
                                      'importanciaEcologica':
                                          plant.ecologicalImportance,
                                      'usosHumanos': plant.humanUses,
                                      'estadoConservacao':
                                          plant.conservationStatus,
                                      'curiosidades': plant.curiosities,
                                    },
                                  ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            7,
                            141,
                            110,
                          ),
                          fixedSize: const Size(140, 12),
                        ),
                        child: const Text(
                          'Conhecer',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: Icon(
                          plant.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: plant.isFavorite ? Colors.red : Colors.grey,
                          size: 28,
                        ),
                        onPressed: () => favoriteStore.toggleFavorite(plant),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  plant.imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.eco,
                        color: Color.fromARGB(255, 7, 141, 110),
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
