import 'package:flutter/material.dart';
import '../widgets/full_screen_image_modal.dart';
import '../models/ecosystem.dart';

class EcosystemDetailScreen extends StatelessWidget {
  final Ecosystem ecosystem;

  const EcosystemDetailScreen({Key? key, required this.ecosystem})
    : super(key: key);

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
                            FullScreenImageModal(imageUrl: ecosystem.imagem2),
                  ),
                );
              },
              child: FlexibleSpaceBar(
                background: Image.asset(
                  ecosystem.imagem2,
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
          // ... resto do código existente ...
        ],
      ),
    );
  }
}
