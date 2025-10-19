import 'package:flutter/material.dart';
import 'quiz_vida_fora_da_terra_screen.dart';

class VidaForaDaTerraScreen extends StatefulWidget {
  const VidaForaDaTerraScreen({super.key});

  @override
  State<VidaForaDaTerraScreen> createState() => _VidaForaDaTerraScreenState();
}

class _VidaForaDaTerraScreenState extends State<VidaForaDaTerraScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Map<String, dynamic>> _planets = [
    {
      'title': 'Marte',
      'image': 'assets/img-principal/marte.png',
      'description': 'Conhecido como o "Planeta Vermelho", Marte tem sido o foco de inúmeras missões espaciais. Sua superfície é coberta por óxido de ferro, dando-lhe a cor avermelhada. Apesar de sua atmosfera fina, evidências sugerem que Marte já teve água líquida em sua superfície, tornando-o um dos principais candidatos para a busca de vida fora da Terra.',
    },
    {
      'title': 'Europa',
      'image': 'assets/img-principal/europa.png',
      'description': 'Uma das luas de Júpiter, Europa é coberta por uma camada de gelo. Acredita-se que exista um oceano de água líquida sob sua superfície, aquecido por forças de maré. Esse ambiente pode ser ideal para formas de vida microbiana.',
    },
    {
      'title': 'Titã',
      'image': 'assets/img-principal/tita.png',
      'description': 'A maior lua de Saturno, Titã, possui uma atmosfera densa e lagos de metano líquido. Embora seja muito frio para a vida como a conhecemos, sua química complexa pode oferecer pistas sobre como a vida pode surgir em outros mundos.',
    },
    {
      'title': 'Exoplanetas',
      'image': 'assets/img-principal/exoplaneta.png',
      'description': 'Exoplanetas são planetas que orbitam estrelas fora do nosso sistema solar. Alguns deles estão na "zona habitável", onde as condições podem ser adequadas para a existência de água líquida e, possivelmente, vida.',
    },
    {
      'title': 'Kepler-452b',
      'image': 'assets/img-principal/kepler452b.png',
      'description': 'Conhecido como o "primo da Terra", Kepler-452b é um exoplaneta localizado na zona habitável de sua estrela. Ele é maior que a Terra, mas pode ter características semelhantes, como água líquida e uma atmosfera estável.',
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
              'assets/img-principal/alien.png',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            const Text(
              'Vida Fora da Terra',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1B1B2F)],
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
                'Explorando planetas e as estrelas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Explore os mistérios do universo e descubra como os planetas e seus ecossistemas podem abrigar vida. Desde Marte até exoplanetas distantes, a busca por vida fora da Terra é uma das maiores aventuras da humanidade.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),

              ..._planets.asMap().entries.map((entry) {
                final index = entry.key;
                final planet = entry.value;
                return AnimatedPlanetCard(
                  slideAnimation: _createSlideAnimation(index),
                  fadeAnimation: _createFadeAnimation(index),
                  title: planet['title'],
                  imagePath: planet['image'],
                  description: planet['description'],
                );
              }).toList(),

              const SizedBox(height: 24),
              Center(
                child: AnimatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizVidaForaDaTerraScreen()),
                    );
                  },
                  text: 'Quiz Interativo',
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedPlanetCard extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final String title;
  final String imagePath;
  final String description;

  const AnimatedPlanetCard({
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
                          fontSize: 20,
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