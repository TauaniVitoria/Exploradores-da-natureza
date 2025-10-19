import 'package:flutter/material.dart';
import 'jogo_memoria.dart';

class SeresDoPassadoScreen extends StatefulWidget {
  const SeresDoPassadoScreen({super.key});

  @override
  State<SeresDoPassadoScreen> createState() => _SeresDoPassadoScreenState();
}

class _SeresDoPassadoScreenState extends State<SeresDoPassadoScreen>
  with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Map<String, dynamic>> _cards = [
    {
      'title': 'Dinossauro - Tyrannosaurus Rex',
      'image': 'assets/img-principal/trex.png',
      'description':
          'O Tyrannosaurus Rex, ou T-Rex, foi um dos maiores predadores que já existiram. Ele viveu há cerca de 68 milhões de anos e podia atingir até 12 metros de comprimento.',
    },
    {
      'title': 'Mamute Lanoso',
      'image': 'assets/img-principal/mamute.png',
      'description':
          'O Mamute Lanoso era um parente distante dos elefantes modernos. Ele viveu durante a Era do Gelo e era adaptado para climas frios, com sua pelagem espessa e presas longas.',
    },
    {
      'title': 'Tigre-dentes-de-sabre',
      'image': 'assets/img-principal/tigre_dentes_de_sabre.png',
      'description':
          'O Tigre-dentes-de-sabre, ou Smilodon, era um predador feroz que viveu há cerca de 10 mil anos. Ele é conhecido por seus longos dentes caninos, que podiam medir até 18 centímetros.',
    },
    {
      'title': 'Pterossauro',
      'image': 'assets/img-principal/pterossauro.png',
      'description':
          'Os Pterossauros foram répteis voadores que viveram durante a Era dos Dinossauros. Eles não eram dinossauros, mas compartilhavam o mesmo período e podiam ter envergaduras de até 10 metros.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Animation<Offset> _createSlideAnimation(int index) {
    return Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.2 * index,
          0.2 * index + 0.7,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  Animation<double> _createFadeAnimation(int index) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.2 * index,
          0.2 * index + 0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img-principal/dino.png',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            const Text(
              'Seres do Passado',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF004D40),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF004D40), Color(0xFF1B5E20)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descubra os gigantes que já dominaram a Terra!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                'Explore os incríveis seres que habitaram o passado do nosso planeta. Descubra curiosidades sobre dinossauros, mamutes, tigres-dentes-de-sabre e muito mais!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(234, 255, 255, 255),
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),

              ..._cards.asMap().entries.map((entry) {
                final index = entry.key;
                final card = entry.value;
                return AnimatedCard(
                  slideAnimation: _createSlideAnimation(index),
                  fadeAnimation: _createFadeAnimation(index),
                  title: card['title'],
                  imagePath: card['image'],
                  description: card['description'],
                );
              }).toList(),

              const SizedBox(height: 24),
              Center(
                child: AnimatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MemoryGameScreen()),
                    );
                  },
                  text: 'Jogo Interativo',
                  colors: [Colors.green, Colors.teal],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedCard extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final String title;
  final String imagePath;
  final String description;

  const AnimatedCard({
    super.key,
    required this.slideAnimation,
    required this.fadeAnimation,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.0, 0.5],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final List<Color> colors;

  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
              horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: colors.last.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              shadows: [
                BoxShadow(
                  color: colors.last.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(1, 1),
                )
              ],
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}