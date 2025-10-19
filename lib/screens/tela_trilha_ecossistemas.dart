import 'package:flutter/material.dart';
import '../model/modelo_ecossistema.dart';
import '../services/servico_ecossistema.dart';
import 'tela_detalhes_ecossistema.dart';

class TelaTrilhaEcossistemas extends StatefulWidget {
  const TelaTrilhaEcossistemas({super.key});

  @override
  State<TelaTrilhaEcossistemas> createState() => _TelaTrilhaEcossistemasState();
}

class _TelaTrilhaEcossistemasState extends State<TelaTrilhaEcossistemas> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trilha dos Ecossistemas'),
        centerTitle: true,
      ),
      body:
          _carregando
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _ecossistemas.length,
                itemBuilder: (context, index) {
                  final ecossistema = _ecossistemas[index];
                  return _construirCardEcossistema(ecossistema);
                },
              ),
    );
  }

  Widget _construirCardEcossistema(Ecossistema ecossistema) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ecossistema.corBorda, width: 2),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      TelaDetalhesEcossistema(ecossistema: ecossistema),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: ecossistema.corFundo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.asset(ecossistema.urlImagem, fit: BoxFit.cover),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ecossistema.nome,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ecossistema.tipo,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
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
}
