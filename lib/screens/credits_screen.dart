import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({Key? key}) : super(key: key);

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Créditos', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 7, 141, 110),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Disciplina:'),
            _buildSectionContent('Desenvolvimento de Software'),

            _buildSectionTitle('Professor:'),
            _buildSectionContent('Prof. Dr. Elvio Gilberto da Silva'),

            _buildSectionTitle('Integrantes e Colaboradores:'),
            _buildSectionContent(
              'Fernando Henrique Correa\n'
              'Guilherme de Melo Jardim\n'
              'Jhuliani Cristina dos Santos Amorim\n'
              'Tauani Vitoria Ferreira',
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            const Center(
              child: Text(
                'Desenvolvimento:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset(
                'assets/creditos/Ciencia_da_Computacao.jpg',
                height: 150,
              ),
            ),

            const SizedBox(height: 32),
            const Center(
              child: Text(
                'Apoio:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset(
                'assets/creditos/coordenadoria-de-extensao.jpg',
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
