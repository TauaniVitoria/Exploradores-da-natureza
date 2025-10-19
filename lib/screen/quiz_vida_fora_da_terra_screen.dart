import 'package:flutter/material.dart';

class QuizVidaForaDaTerraScreen extends StatefulWidget {
  const QuizVidaForaDaTerraScreen({super.key});

  @override
  State<QuizVidaForaDaTerraScreen> createState() => _QuizVidaForaDaTerraScreenState();
}

class _QuizVidaForaDaTerraScreenState extends State<QuizVidaForaDaTerraScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Qual é o principal motivo para Marte ser considerado um candidato para abrigar vida?',
      'options': [
        'Sua atmosfera rica em oxigênio.',
        'A presença de água líquida no passado.',
        'Sua proximidade com o Sol.',
        'A existência de florestas em sua superfície.'
      ],
      'answerIndex': 1, // Resposta correta: A presença de água líquida no passado.
      'explanation': 'Evidências sugerem que Marte já teve água líquida em sua superfície, tornando-o um dos principais candidatos para a busca de vida fora da Terra.',
    },
    {
      'question': 'O que torna Europa, uma das luas de Júpiter, interessante para a busca de vida?',
      'options': [
        'Sua atmosfera rica em oxigênio.',
        'A presença de um oceano de água líquida sob sua superfície de gelo.',
        'A existência de florestas em sua superfície.',
        'Sua proximidade com o Sol.'
      ],
      'answerIndex': 1, // Resposta correta: A presença de um oceano de água líquida sob sua superfície de gelo.
      'explanation': 'Europa é coberta por uma camada de gelo, e acredita-se que exista um oceano de água líquida sob sua superfície, aquecido por forças de maré.',
    },
    {
      'question': 'O que são exoplanetas?',
      'options': [
        'Planetas que orbitam estrelas fora do nosso sistema solar.',
        'Planetas que orbitam apenas o Sol.',
        'Planetas que possuem atmosfera rica em oxigênio.',
        'Planetas que possuem florestas densas.'
      ],
      'answerIndex': 0, // Resposta correta: Planetas que orbitam estrelas fora do nosso sistema solar.
      'explanation': 'Exoplanetas são planetas que orbitam estrelas fora do nosso sistema solar. Alguns deles estão na "zona habitável", onde as condições podem ser adequadas para a existência de água líquida.',
    },
    {
      'question': 'Por que Kepler-452b é chamado de "primo da Terra"?',
      'options': [
        'Porque possui florestas densas.',
        'Porque está localizado na zona habitável de sua estrela.',
        'Porque é do mesmo tamanho da Terra.',
        'Porque possui oceanos de metano.'
      ],
      'answerIndex': 1, // Resposta correta: Porque está localizado na zona habitável de sua estrela.
      'explanation': 'Kepler-452b é chamado de "primo da Terra" porque está localizado na zona habitável de sua estrela, onde as condições podem ser adequadas para a existência de água líquida.',
    },
    {
      'question': 'Qual é a principal característica de Titã, a maior lua de Saturno?',
      'options': [
        'Possui lagos de metano líquido.',
        'É coberta por florestas densas.',
        'Possui uma atmosfera rica em oxigênio.',
        'É o maior planeta do sistema solar.'
      ],
      'answerIndex': 0, // Resposta correta: Possui lagos de metano líquido.
      'explanation': 'Titã possui uma atmosfera densa e lagos de metano líquido, tornando-a única no sistema solar.',
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
        backgroundColor: Color(0xFF1B1B2F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quiz Cósmico',
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
            colors: [Color(0xFF1B1B2F), Color(0xFF0D47A1)],
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
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlue),
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
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
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
                              splashColor: Colors.lightBlue.withOpacity(0.2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.withOpacity(0.15),
                                      Colors.blue.withOpacity(0.05),
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
                      style: TextStyle(color: Colors.white)),
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
