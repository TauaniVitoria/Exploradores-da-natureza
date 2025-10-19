// SEGUNDA TELA - O USUÁRIO INSERE SEU NOME + ESCOLHE UMA IMAGEM DE PERFIL
// TERCEIRA TELA (lá embaixo) - EXIBE A MENSAGEM DE CADASTRO CONCLUÍDO

import 'package:flutter/material.dart';
import 'screen-principal.dart';

String nomeUsuario = ''; // Variavel GLOBAL que armazena o nome do usuário
String avatarSelecionado = '';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  int? _selectedAvatar;
  String? _errorMessage;

  final List<String> avatarPaths = [
    'assets/img-screen-login/dragon.jpg',
    'assets/img-screen-login/ghost.jpg',
    'assets/img-screen-login/pumpkin.jpg',
  ];

  void _submitForm() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() => _errorMessage = 'Por favor, insira seu nome ou apelido.');
      return;
    }

    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>1234567890]').hasMatch(name)) {
      setState(
        () =>
            _errorMessage =
                'Use apenas letras. Números e símbolos não são permitidos.',
      );
      return;
    }

    if (_selectedAvatar == null) {
      setState(() => _errorMessage = 'Selecione um avatar para continuar.');
      return;
    }

    avatarSelecionado = avatarPaths[_selectedAvatar!]; // agora é seguro!

    nomeUsuario = name;

    setState(() => _errorMessage = null);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessScreen(userName: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 121, 88),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cadastro',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 46, 37),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Text(
                      'Digite seu nome, ou um apelido, usando apenas letras. Evite números, espaços ou símbolos como @, # ou %',
                      style: TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color.fromRGBO(95, 95, 95, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    if (_errorMessage != null) ...[
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    const SizedBox(height: 24),
                    Text(
                      'Foto de perfil',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 46, 37),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Text(
                      'Agora escolha o seu avatar: um unicórnio mágico, uma abóbora misteriosa ou um fantasminha!',
                      style: TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 28),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: avatarPaths.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, index) {
                        final isSelected = _selectedAvatar == index;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedAvatar = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.greenAccent
                                        : Colors.transparent,
                                width: 4,
                              ),
                              boxShadow:
                                  isSelected
                                      ? [
                                        BoxShadow(
                                          color: Colors.greenAccent,
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                      : [],
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[100],
                              backgroundImage: AssetImage(avatarPaths[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ], // children do Column onde estão os elementos principais
                ),
              ),
            ),

            // Botao proximo
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 7, 141, 110),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela de login efetuado com sucesso
class SuccessScreen extends StatelessWidget {
  final String userName;

  const SuccessScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 121, 88),
      body: SafeArea(
        child: Column(
          children: [
            // Conteúdo com padding
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Cadastro bem-sucedido!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(flex: 2),
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 600),
                      tween: Tween(begin: 0.75, end: 1.0),
                      curve: Curves.easeOutBack,
                      builder:
                          (context, value, child) =>
                              Transform.scale(scale: value, child: child),
                      child: Image.asset(
                        'assets/img-screen-login/happy-child.png',
                        height: 360,
                        width: 360,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      builder:
                          (context, value, child) => Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          ),
                      child: const Text(
                        'Parabéns você terminou o seu cadastro, agora aperte o botão abaixo para continuar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),

            // Botão fora do Padding principal
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 4, 121, 88),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
