import 'package:flutter/material.dart';
import '../model/modelo_ecossistema.dart';
import '../widgets/full_screen_image_modal.dart';

class TelaDetalhesEcossistema extends StatelessWidget {
  final Ecossistema ecossistema;

  const TelaDetalhesEcossistema({super.key, required this.ecossistema});

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
                        (context) => FullScreenImageModal(
                          imageUrl: ecossistema.urlImagem2,
                        ),
                  ),
                );
              },
              child: FlexibleSpaceBar(
                background: Image.asset(
                  ecossistema.urlImagem2,
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
            backgroundColor: const Color.fromARGB(255, 7, 141, 110),
          ),

          // Conteúdo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome e tipo
                  Text(
                    ecossistema.nome,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 141, 110),
                    ),
                  ),
                  Text(
                    ecossistema.tipo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Seções de informação
                  _buildInfoSection('Localização', ecossistema.localizacao),
                  _buildInfoSection(
                    'Características',
                    ecossistema.caracteristicas,
                  ),
                  _buildInfoSection(
                    'Nicho Ecológico',
                    ecossistema.nichoEcologico,
                  ),
                  _buildInfoSection(
                    'Cadeia Alimentar',
                    ecossistema.cadeiaAlimentar,
                  ),
                  _buildInfoSection(
                    'Importância Ecológica',
                    ecossistema.importanciaEcologica,
                  ),
                  _buildInfoSection('Ameaças', ecossistema.ameacas),
                  _buildInfoSection(
                    'Ações de Conservação',
                    ecossistema.acoesConservacao,
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
      padding: const EdgeInsets.only(bottom: 16),
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
          Text(
            content,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
