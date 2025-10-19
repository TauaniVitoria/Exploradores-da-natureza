import 'package:flutter/material.dart';
import '../widgets/full_screen_image_modal.dart';
import '../models/animal.dart';

class AnimalDetailsScreen extends StatelessWidget {
  final Animal animal;

  const AnimalDetailsScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Imagem de capa com título
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            FullScreenImageModal(imageUrl: animal.imageAsset2),
                  ),
                );
              },
              child: FlexibleSpaceBar(
                background: Image.asset(
                  animal.imageAsset2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 50,
                    );
                  },
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 7, 141, 110),
          ),

          // Conteúdo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome comum e científico
                  Text(
                    animal.commonName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 141, 110),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    animal.scientificName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Seções de informação
                  _buildInfoSection('Habitat', animal.habitat),
                  _buildInfoSection(
                    'Distribuição Geográfica',
                    animal.geographicDistribution,
                  ),
                  _buildInfoSection('Alimentação', animal.feeding),
                  _buildInfoSection('Comportamento', animal.behavior),
                  _buildInfoSection('Nicho Ecológico', animal.ecologicalNiche),
                  _buildInfoSection(
                    'Estado de Conservação',
                    animal.conservationStatus,
                  ),

                  // Curiosidades
                  const SizedBox(height: 16),
                  const Text(
                    'Curiosidades',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 141, 110),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...animal.curiosities.map(
                    (curiosidade) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(
                              Icons.star,
                              size: 16,
                              color: Color.fromARGB(255, 7, 141, 110),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              curiosidade,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Espaço no final
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 7, 141, 110),
            ),
          ),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
