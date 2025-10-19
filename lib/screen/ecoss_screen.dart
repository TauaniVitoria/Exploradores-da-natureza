import 'package:flutter/material.dart';
import '../model/modelo_ecossistema.dart';
import '../services/servico_ecossistema.dart';
import '../card/ecoss_card.dart';
import 'screen-favorite.dart';

class EcosystemsScreen extends StatefulWidget {
  const EcosystemsScreen({super.key});

  @override
  State<EcosystemsScreen> createState() => _EcosystemsScreenState();
}

class _EcosystemsScreenState extends State<EcosystemsScreen> {
  final ServicoEcossistema _servicoEcossistema = ServicoEcossistema();
  List<Ecossistema> _ecossistemas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarEcossistemas();
  }

  Future<void> _carregarEcossistemas() async {
    try {
      final ecossistemas = await _servicoEcossistema.obterEcossistemas();
      setState(() {
        _ecossistemas = ecossistemas;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _carregando = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao carregar ecossistemas'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Map<String, List<Ecossistema>> _groupByCategory() {
    final Map<String, List<Ecossistema>> grouped = {};
    for (final ecossistema in _ecossistemas) {
      grouped.putIfAbsent(ecossistema.tipo, () => []);
      grouped[ecossistema.tipo]!.add(ecossistema);
    }
    return grouped;
  }

  String _getCategoryDescription(String category) {
    const descriptions = {
      'Desertos':
          'Mesmo com pouca água, esse ecossistema abriga animais noturnos, plantas com armazenamento de água e paisagens de tirar o fôlego.',
      'Florestas':
          'As florestas são os pulmões do planeta! Com árvores altas, grande biodiversidade e muitos níveis de vida.',
      'Oceanos e Mares':
          'Os oceanos cobrem a maior parte da Terra e são cheios de vida. Além de maravilhosos, os oceanos influenciam o clima e fornecem alimento para bilhões de pessoas.',
      'Savanas':
          'Com suas planícies extensas e árvores espaçadas, as savanas são o palco de muitos dos animais mais icônicos do mundo.',
      'Pântanos e Manguezais':
          'Os pântanos são áreas úmidas ricas em biodiversidade que funcionam como filtros naturais, limpando a água e protegendo contra enchentes.',
      'Tundras':
          'Localizadas próximas aos polos, o solo congelado e o clima extremo desafiam a vida, mas ainda assim, os seres resistem com força e beleza neste ambiente único.',
    };
    return descriptions[category] ?? 'Descrição para a categoria $category';
  }

  void _showCategoryDetails(
    BuildContext context,
    String category,
    List<Ecossistema> ecossistemas,
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
                          itemCount: ecossistemas.length,
                          itemBuilder: (context, index) {
                            return EcosystemCard(
                              ecosystem: ecossistemas[index],
                            );
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
    if (_carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final Map<String, List<Ecossistema>> groupedEcosystems = _groupByCategory();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 121, 88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Trilha dos Ecossistemas',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bem-vindo ao catálogo de Ecossistemas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Explore os diferentes tipos de ecossistemas e descubra suas características únicas.',
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                  ...groupedEcosystems.entries.map((entry) {
                    List<Ecossistema> categoryEcosystems = entry.value;
                    List<Ecossistema> displayedEcosystems =
                        categoryEcosystems.length > 3
                            ? categoryEcosystems.sublist(0, 3)
                            : categoryEcosystems;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        Text(
                          _getCategoryDescription(entry.key),
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
                          itemCount: displayedEcosystems.length,
                          itemBuilder: (context, index) {
                            return EcosystemCard(
                              ecosystem: displayedEcosystems[index],
                            );
                          },
                        ),
                        if (categoryEcosystems.length > 3)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(8.0),
                              ),
                              onPressed:
                                  () => _showCategoryDetails(
                                    context,
                                    entry.key,
                                    categoryEcosystems,
                                  ),
                              child: const Text(
                                'Ver mais',
                                style: TextStyle(
                                  color: Color(0xFF1B5E20),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
