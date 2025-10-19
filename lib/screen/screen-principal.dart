// QUARTA TELA - Tela principal
import 'package:flutter/material.dart';
import 'plant_screen.dart';
import 'screen-login.dart';
import 'animal_screen.dart';
import 'ecoss_screen.dart';
import '../screens/credits_screen.dart';
import 'seres_do_passado_screen.dart';
import 'vida_invisivel.dart';
import 'vida_fora_da_terra_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 121, 88),
        title: Text('Exploradores da Natureza',
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Olá ',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: nomeUsuario,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Seja bem-vindo(a) à aventura!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),

                // Avatar no canto superior direito
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(avatarSelecionado),
                  backgroundColor: Colors.grey[200],
                ),
              ],
            ),

            // Carrossel retangular - Assuntos interessantes
            SizedBox(height: 24),
            Text(
              'Explorações além da natureza',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Descubra curiosidades incríveis, aqui você vai além do que os olhos veem e aprende sobre o mundo ao seu redor!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customComplexButton(
                    context,                                     
                    'Seres do Passado',
                    'Descubra os gigantes \nque dominaram a Terra!',
                    'assets/img-principal/icon-dino.png',
                    [
                      const Color.fromARGB(255, 0, 42, 255), 
                      const Color.fromARGB(255, 83, 112, 255), 
                      const Color.fromARGB(255, 141, 160, 254),    
                    ],
                    SeresDoPassadoScreen(),
                  ),
                  SizedBox(width: 10),
                  customComplexButton(
                    context,                                     
                    'A vida fora da Terra',
                    'Explorando planetas \ne as estrelas',
                    'assets/img-principal/icon-planet.png',
                    [
                      const Color.fromARGB(255, 202, 69, 255), 
                      const Color.fromARGB(255, 214, 110, 255), 
                      const Color.fromARGB(255, 230, 173, 255), 
                    ],
                    VidaForaDaTerraScreen(),
                  ),
                  SizedBox(width: 10),
                  customComplexButton(
                    context,                                     
                    'O mundo invisível',
                    'Microscópicos, mas \nmuito importantes',
                    'assets/img-principal/icon-bacteria.png',
                    [
                      const Color.fromARGB(255, 255, 88, 121), 
                      const Color.fromARGB(255, 254, 142, 187), 
                      const Color.fromARGB(255, 255, 173, 215),
                    ],
                    VidaInvisivelScreen(),
                  ),
                ],
              ),
            ),

            // Carrossel quadrado - Categorias
            SizedBox(height: 24),
            Text(
              'Escolha sua trilha de exploração',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),

            SizedBox(height: 8),
            Text(
              'Cada trilha leva a um novo conhecimento! Você pode explorar animais, plantas ou ecossistemas. Pronto para começar sua aventura?',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryItem(
                    context,
                    'Animais',
                    AnimalsScreen(),
                    'assets/img-principal/img-animal.jpeg'
                  ),
                  SizedBox(width: 10),
                  _buildCategoryItem(
                    context,
                    'Plantas',
                    PlantScreen(),
                      'assets/img-principal/img-planta.jpeg'
                  ),
                  SizedBox(width: 10),
                  _buildCategoryItem(
                    context,
                    'Ecossistemas',
                    EcosystemsScreen(),
                      'assets/img-principal/img-eco.jpeg'
                  ),
                ],
              ),
            ),

            // Texto "Sustentabilidade"
            SizedBox(height: 24),
            Text(
              'Sustentabilidade: Palavra Difícil, Atitude Bonita',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),

            // Sustetabilidade CARDS
            Text(
              //• \n
              'Sustentabilidade é uma palavra que significa usar os recursos da natureza de maneira equilibrada e responsável, sem prejudicar o meio ambiente. '
                  'Ser sustentável é fazer escolhas que ajudam o planeta todos os dias.',
              softWrap: true,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            // Subtítulo
            Text(
              'Veja algumas dicas para ser um amigo da natureza:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

// Na seção de Sustentabilidade
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            CustomCard(
                              context,
                              Icons.eco,
                              'Plante uma Semente!',
                              'Cuidar de uma plantinha ensina \nsobre paciência e a importância da natureza.',
                              'assets/img-principal/img-planting.jpg',
                            ),
                            CustomCard(
                              context,
                              Icons.delete_sharp,
                              'Separe o Lixo!',
                              'Coloque papel, plástico, vidro e metal nos lugares certos para ajudar a reciclar.',
                              'assets/img-principal/img-trash.jpg',
                            ),

                            CustomCard(
                              context,
                              Icons.build,
                              'Feche a Torneira!',
                              'Enquanto escova os dentes ou ensaboa as mãos, feche a torneira.',
                              'assets/img-principal/img-torneira.jpg',
                            ),
                            CustomCard(
                              context,
                              Icons.recycling,
                              'Reutilize Materiais!',
                              'Transforme caixas, potes e papel usados em brinquedos ou artesanato.',
                              'assets/img-principal/img-planet.jpg',
                            ),
                            CustomCard(
                              context,
                              Icons.restaurant_outlined,
                              'Tire os Aparelhos da Tomada!',
                              'Mesmo desligados, eles podem continuar gastando energia.',
                              'assets/img-principal/img-lampada.jpg',
                            ),




                          ],
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            const SizedBox(height: 16),
            
            // Texto "Seja um explorador"
            SizedBox(height: 24),
            Text(
              'Juntos, Podemos Ser Exploradores do Planeta!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Seja um explorador da natureza! '
                  'Vamos agir com amor e respeito pela Terra, para que ela continue a nos dar tudo o que precisamos para viver!',
              softWrap: true,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            // Créditos
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AspectRatio(
                aspectRatio: 3.5, // Mantém a proporção ideal da logo
                child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.97, end: 1.0),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, value, child) => Transform.scale(
                    scale: value,
                    child: child,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      splashColor: Colors.tealAccent.withOpacity(0.1),
                      highlightColor: Colors.teal.withOpacity(0.05),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) => const CreditsScreen(),
                            transitionsBuilder: (_, animation, __, child) => FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation.drive(
                                  Tween(begin: 0.95, end: 1.0)
                                      .chain(CurveTween(curve: Curves.easeOut)),
                                ),
                                child: child,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage('assets/img-principal/unisagrado-logo.png'),
                            fit: BoxFit.contain,
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.0,
                          ),
                        ),
                        child: Semantics(
                          label: 'Logo UNISAGRADO. Toque para ver os créditos.',
                          button: true,
                        ),
                      ),
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
  // Contruindo os widgets pro carrossel 1

Widget customComplexButton(
  BuildContext context,
  String title,
  String subtitle,
  String imagePath,
  List<Color> gradientColors,
  Widget destinationScreen,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationScreen),
      );
    },
    borderRadius: BorderRadius.circular(20),
    child: Container(
      width: 300,
      height: 120,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Coluna com título e subtítulo
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                      ),
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12
                        ),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
            ),
          ),
        ],
      ),
    ),
  );
}

// Carrossel 2
Widget _buildCategoryItem(
    BuildContext context,
    String label,
    Widget destination,
    String imagePath,
    ) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.white.withOpacity(0.2),
      splashFactory: InkRipple.splashFactory,
      elevation: 0,
    ),
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => destination,
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      );
    },
    child: Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.1),
            BlendMode.darken,
          ),

        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Texto centralizado vertical e horizontalmente
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 6,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),

                  // Botão na parte inferior
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}




// CARDS DE SUSTENTABILIDADE
Widget CustomCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String imagePath,
    ) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ), // Fechamento do shape corrigido
        backgroundColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.3),
        elevation: 6,
        foregroundColor: Colors.white.withOpacity(0.2),
      ),
      onPressed: () {},
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.green[800],
                  size: 28,
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 6,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}