import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/animal.dart';
import '../provider/favorite_store.dart';
import '../screen/animal_details_screen.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;

  const AnimalCard({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    final favoriteStore = Provider.of<FavoriteStore>(context);

    return Card(
      elevation: 4, // sombra
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
            // CHILD 1: TÍTULO E SUBTÍTULO
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Nome e Categoria na mesma linha
                Row(
                  children: [
                    Text(
                      animal.commonName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ), // Espaçamento entre o nome e a categoria
                    Text(
                      '${animal.category[0].toUpperCase()}${animal.category.substring(1).toLowerCase()}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(221, 136, 136, 136),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ), // Espaçamento entre a linha e o texto abaixo
                Text(
                  animal.scientificName,
                  style: TextStyle(color: Colors.grey[700]),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),

                // Botão "Conhecer" e Ícone de Favorito ao lado
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    AnimalDetailsScreen(animal: animal),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 141, 110),
                        fixedSize: const Size(140, 12), // largura x altura
                      ),
                      child: const Text(
                        'Conhecer',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ), // Espaçamento entre o botão e o ícone
                    IconButton(
                      icon: Icon(
                        animal.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: animal.isFavorite ? Colors.red : Colors.grey,
                        size: 28,
                      ),
                      onPressed: () => favoriteStore.toggleFavorite(animal),
                    ),
                  ],
                ),
              ],
            ),

            // CHILD 2: Imagem do animal
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    8,
                  ), // Espaçamento entre o contorno e a imagem
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      animal.imageAsset,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
