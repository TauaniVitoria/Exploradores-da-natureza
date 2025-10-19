import 'package:flutter/material.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  final List<Map<String, String>> _cards = [
    {'name': 'T-Rex', 'image': 'assets/img-principal/trex.png'},
    {'name': 'Mamute', 'image': 'assets/img-principal/mamute.png'},
    {'name': 'Tigre-dentes-de-sabre', 'image': 'assets/img-principal/tigre_dentes_de_sabre.png'},
    {'name': 'Pterossauro', 'image': 'assets/img-principal/pterossauro.png'},
  ];

  late List<Map<String, String>> _shuffledCards;
  List<int> _selectedCards = [];
  List<int> _matchedCards = [];
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _shuffledCards = [..._cards, ..._cards]; // Duplicar os cartões para criar pares
    _shuffledCards.shuffle(); // Embaralhar os cartões
    _selectedCards = [];
    _matchedCards = [];
  }

  void _onCardTap(int index) {
    if (_isProcessing || _selectedCards.contains(index) || _matchedCards.contains(index)) {
      return;
    }

    setState(() {
      _selectedCards.add(index);
    });

    if (_selectedCards.length == 2) {
      _checkMatch();
    }
  }

  void _checkMatch() async {
    _isProcessing = true;

    await Future.delayed(const Duration(seconds: 1));

    if (_shuffledCards[_selectedCards[0]]['name'] == _shuffledCards[_selectedCards[1]]['name']) {
      setState(() {
        _matchedCards.addAll(_selectedCards);
        _selectedCards.clear();
      });
    } else {
      setState(() {
        _selectedCards.clear();
      });
    }

    _isProcessing = false;

    if (_matchedCards.length == _shuffledCards.length) {
      _showWinDialog();
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 36),
            const SizedBox(width: 8),
            const Text(
              'Parabéns!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Você completou o jogo da memória!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _initializeGame();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text(
                'Jogar Novamente',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Jogo da Memória',  
         style: TextStyle(fontSize: 22
                  , fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
        backgroundColor: const Color(0xFF004D40), // Verde escuro
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF004D40), Color(0xFF1B5E20)], // Degradê verde escuro
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 colunas para cartões maiores
              crossAxisSpacing: 16, // Espaçamento horizontal
              mainAxisSpacing: 16, // Espaçamento vertical
            ),
            itemCount: _shuffledCards.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedCards.contains(index);
              final isMatched = _matchedCards.contains(index);

              return GestureDetector(
                onTap: () => _onCardTap(index),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return RotationYTransition(
                      animation: animation,
                      child: child,
                    );
                  },
                  child: isMatched || isSelected
                      ? ClipRRect(
                          key: ValueKey('card_front_$index'),
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage(_shuffledCards[index]['image']!),
                                fit: BoxFit.cover, // Ajusta a imagem para preencher o cartão
                              ),
                            ),
                          ),
                        )
                      : Card(
                          key: ValueKey('card_back_$index'),
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Icon(
                            Icons.question_mark,
                            color: Colors.white,
                            size: 48, // Ícone maior para melhor visibilidade
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RotationYTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const RotationYTransition({super.key, required this.child, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final angle = animation.value * 3.1415926535897932; // Pi para rotação
        final transform = Matrix4.identity()..rotateY(angle);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: animation.value <= 0.5 ? child : this.child,
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}