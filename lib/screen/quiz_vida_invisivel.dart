import 'package:flutter/material.dart';

class QuizVidaInvisivelScreen extends StatefulWidget {
  const QuizVidaInvisivelScreen({super.key});

  @override
  State<QuizVidaInvisivelScreen> createState() => _QuizVidaInvisivelScreenState();
}

class _QuizVidaInvisivelScreenState extends State<QuizVidaInvisivelScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Qual é o papel das bactérias no intestino humano?',
      'options': [
        'Produzir oxigênio para o corpo.',
        'Ajudar na digestão e na absorção de nutrientes.',
        'Causar doenças como a malária.',
        'Realizar fotossíntese para gerar energia.'
      ],
      'answerIndex': 1, // Resposta correta: Ajudar na digestão e na absorção de nutrientes.
      'explanation': 'As bactérias no intestino humano, como a Escherichia coli, ajudam na digestão e na absorção de nutrientes, além de contribuírem para a saúde geral do sistema digestivo.',
    },
    {
      'question': 'Qual é o papel dos fungos microscópicos na produção de alimentos?',
      'options': [
        'Eles realizam fotossíntese para produzir açúcares.',
        'Eles fermentam carboidratos para produzir pão e bebidas.',
        'Eles fixam nitrogênio no solo para as plantas.',
        'Eles produzem oxigênio durante a fermentação.'
      ],
      'answerIndex': 1, // Resposta correta: Eles fermentam carboidratos para produzir pão e bebidas.
      'explanation': 'Fungos microscópicos, como a levedura Saccharomyces cerevisiae, fermentam carboidratos para produzir dióxido de carbono e álcool, usados na fabricação de pão, cerveja e vinho.',
    },
    {
      'question': 'Por que as algas microscópicas são importantes para os ecossistemas aquáticos?',
      'options': [
        'Elas produzem antibióticos para combater doenças.',
        'Elas são a base da cadeia alimentar e produzem oxigênio.',
        'Elas fixam nitrogênio no solo para as plantas.',
        'Elas decompõem matéria orgânica para liberar nutrientes.'
      ],
      'answerIndex': 1, // Resposta correta: Elas são a base da cadeia alimentar e produzem oxigênio.
      'explanation': 'As algas microscópicas, como as diatomáceas, produzem oxigênio através da fotossíntese e servem como base da cadeia alimentar em ecossistemas aquáticos.',
    },
    {
      'question': 'O que diferencia as arqueas das bactérias?',
      'options': [
        'Elas realizam fotossíntese para produzir energia.',
        'Elas possuem uma membrana celular única e vivem em ambientes extremos.',
        'Elas produzem oxigênio durante a respiração celular.',
        'Elas causam doenças em humanos e animais.'
      ],
      'answerIndex': 1, // Resposta correta: Elas possuem uma membrana celular única e vivem em ambientes extremos.
      'explanation': 'As arqueas possuem uma composição única de membrana celular que as torna altamente resistentes a condições extremas, como altas temperaturas e salinidade.',
    },
    {
      'question': 'Como os protozoários contribuem para os ecossistemas?',
      'options': [
        'Eles produzem oxigênio através da fotossíntese.',
        'Eles controlam populações de bactérias e servem de alimento para outros organismos.',
        'Eles fixam nitrogênio no solo para as plantas.',
        'Eles decompõem matéria orgânica para liberar nutrientes.'
      ],
      'answerIndex': 1, // Resposta correta: Eles controlam populações de bactérias e servem de alimento para outros organismos.
      'explanation': 'Protozoários, como as amebas, controlam populações de bactérias e servem como fonte de alimento para organismos maiores, desempenhando um papel crucial nos ecossistemas aquáticos.',
    },
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final progressValue = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2B0000),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quiz das Bactérias',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentQuestionIndex + 1}/${_questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2B0000), Color.fromARGB(255, 103, 3, 16)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 60, 105)),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Text(
                          currentQuestion['question'],
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ...currentQuestion['options'].asMap().entries.map((entry) {
                        final index = entry.key;
                        final option = entry.value;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _checkAnswer(index),
                              splashColor: (Color.fromARGB(63, 255, 60, 105)),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(11, 255, 60, 128),
                                      Color.fromARGB(34, 255, 60, 128),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.15),
                                  ),
                                ),
                                child: Text(
                                  option,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAnswer(int selectedIndex) {
    final isCorrect = selectedIndex == _questions[_currentQuestionIndex]['answerIndex'];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.error,
                color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                size: 60,
              ),
              const SizedBox(height: 20),
              Text(
                isCorrect ? 'Resposta Correta!' : 'Resposta Incorreta',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              if (!isCorrect)
                Text(
                  _questions[_currentQuestionIndex]['explanation'],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (isCorrect) _score++;
                  if (_currentQuestionIndex < _questions.length - 1) {
                    setState(() => _currentQuestionIndex++);
                  } else {
                    _showResultDialog();
                  }
                },
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.rocket_launch,
                color: Colors.lightBlue,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                'Missão Concluída!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$_score',
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' / ${_questions.length}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey[800],
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                    child: const Text(
                      'Sair',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentQuestionIndex = 0;
                        _score = 0;
                      });
                    },
                    child: const Text('Recomeçar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
