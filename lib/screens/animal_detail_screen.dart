import 'package:flutter/material.dart';
import '../widgets/full_screen_image_modal.dart';
import '../models/animal.dart';

class AnimalDetailScreen extends StatelessWidget {
  final Animal animal;

  const AnimalDetailScreen({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(animal.commonName)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem de detalhe com gesto para abrir em tela cheia
            GestureDetector(
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
              child: Image.asset(
                animal.imageAsset2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  );
                },
              ),
            ),
            // ... resto do conteúdo existente ...
          ],
        ),
      ),
    );
  }
}
