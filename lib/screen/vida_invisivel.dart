import 'package:flutter/material.dart';
import 'quiz_vida_invisivel.dart';

class VidaInvisivelScreen extends StatefulWidget {
  const VidaInvisivelScreen({super.key});

  @override
  State<VidaInvisivelScreen> createState() => _VidaInvisivelScreenState();
}

class _VidaInvisivelScreenState extends State<VidaInvisivelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Map<String, dynamic>> _microorganisms = [
    {
      'title': 'Bactérias',
      'image': 'assets/img-principal/bacteria.png',
      'description':
          'As bactérias são organismos unicelulares que podem ser encontrados em praticamente todos os ambientes da Terra. Elas desempenham papéis cruciais na decomposição de matéria orgânica, no ciclo do nitrogênio e na produção de alimentos como iogurte e queijo.',
    },
    {
      'title': 'Vírus',
      'image': 'assets/img-principal/virus.png',
      'description':
          'Os vírus são partículas microscópicas que infectam células vivas para se reproduzir. Eles são responsáveis por doenças como gripe, COVID-19 e HIV.',
    },
    {
      'title': 'Protozoários',
      'image': 'assets/img-principal/protozoario.png',
      'description':
          'Os protozoários são organismos unicelulares eucarióticos que vivem em ambientes aquáticos ou como parasitas. Eles desempenham papéis importantes nos ecossistemas, como controlar populações de bactérias e servir de alimento para outros organismos.',
    },
    {
      'title': 'Fungos Microscópicos',
      'image': 'assets/img-principal/fungo.png',
      'description':
          'Os fungos microscópicos, como leveduras e bolores, são essenciais para a decomposição de matéria orgânica e para a produção de alimentos e bebidas. A levedura Saccharomyces cerevisiae é usada na fermentação de pão, cerveja e vinho.',
    },
    {
      'title': 'Algas Microscópicas',
      'image': 'assets/img-principal/alga.png',
      'description':
          'As algas microscópicas, como as diatomáceas, são responsáveis por cerca de 50% da produção de oxigênio na Terra. Elas são a base da cadeia alimentar em ecossistemas aquáticos.',
    },
    {
      'title': 'Arqueas',
      'image': 'assets/img-principal/arquea.png',
      'description':
          'As arqueas são microorganismos que vivem em ambientes extremos, como fontes termais, lagos salgados e o fundo do oceano. Elas desempenham papéis importantes no ciclo do carbono e na produção de metano.',
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
          0.1 * index,
          0.1 * index + 0.7,
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
          0.1 * index,
          0.1 * index + 0.7,
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
              'assets/img-principal/virus_1198638.png',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            const Text(
              'Vida Invisível',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 97, 0, 18),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 97, 0, 18), Color.fromARGB(255, 174, 11, 41)],
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
                'Microscópicas, mas muito importantes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,                  
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Explore o fascinante mundo dos seres invisíveis ao olho humano. Descubra curiosidades sobre bactérias, vírus, protozoários, fungos microscópicos, algas microscópicas, arqueas e outros microorganismos que desempenham papéis essenciais na vida na Terra!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),

              ..._microorganisms.asMap().entries.map((entry) {
                final index = entry.key;
                final micro = entry.value;
                return AnimatedMicroorganismCard(
                  slideAnimation: _createSlideAnimation(index),
                  fadeAnimation: _createFadeAnimation(index),
                  title: micro['title'],
                  imagePath: micro['image'],
                  description: micro['description'],
                );
              }).toList(),

              const SizedBox(height: 24),
              Center(
                child: AnimatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizVidaInvisivelScreen()),
                    );
                  },
                  text: 'Quiz Interativo',
                  colors: [Colors.red, Colors.orange],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedMicroorganismCard extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final String title;
  final String imagePath;
  final String description;

  const AnimatedMicroorganismCard({
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
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 220,
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
                            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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