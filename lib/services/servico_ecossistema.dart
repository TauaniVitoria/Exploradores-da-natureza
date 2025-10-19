import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../model/modelo_ecossistema.dart';

class ServicoEcossistema {
  static List<Ecossistema>? _ecossistemasCache;
  static final Set<String> _idsFavoritos = {};

  Future<List<Ecossistema>> obterEcossistemas() async {
    if (_ecossistemasCache != null) {
      // Atualiza o estado dos favoritos antes de retornar
      for (var ecossistema in _ecossistemasCache!) {
        ecossistema.favorito = _idsFavoritos.contains(ecossistema.id);
      }
      return _ecossistemasCache!;
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/ecosistemas.json',
      );

      final Map<String, dynamic> jsonResponse = json.decode(jsonString);

      final List<dynamic> ecossistemasJson = jsonResponse['ecosistemas'];

      _ecossistemasCache = [];

      for (var ecossistema in ecossistemasJson) {
        try {
          final id = ecossistema['id'].toString();
          _ecossistemasCache!.add(
            Ecossistema(
              id: id,
              nome: ecossistema['nome'],
              tipo: ecossistema['tipo'],
              urlImagem: ecossistema['imagem'],
              urlImagem2: ecossistema['imagem2'],
              corFundo: _obterCorFundo(ecossistema['tipo']),
              corBorda: _obterCorBorda(ecossistema['tipo']),
              localizacao: ecossistema['localizacao'],
              caracteristicas: ecossistema['caracteristicas'],
              nichoEcologico: ecossistema['nichoEcologico'],
              cadeiaAlimentar: ecossistema['cadeiaAlimentar'],
              importanciaEcologica: ecossistema['importanciaEcologica'],
              ameacas: ecossistema['ameacas'],
              acoesConservacao: ecossistema['acoesConservacao'],
              favorito: _idsFavoritos.contains(id),
            ),
          );
        } catch (e) {
          print('ERRO ao processar ecossistema ${ecossistema['nome']}: $e');
        }
      }

      return _ecossistemasCache!;
    } catch (e) {
      print('ERRO ao carregar ecossistemas: $e');
      rethrow;
    }
  }

  static void toggleFavorito(Ecossistema ecossistema) {
    if (ecossistema.favorito) {
      _idsFavoritos.add(ecossistema.id);
    } else {
      _idsFavoritos.remove(ecossistema.id);
    }
  }

  Color _obterCorFundo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'florestas':
        return const Color(0xFFE8F5E9); // Verde claro
      case 'desertos':
        return const Color(0xFFFFF3E0); // Laranja claro
      case 'oceanos e mares':
        return const Color(0xFFE3F2FD); // Azul claro
      case 'tundras':
        return const Color(0xFFF3E5F5); // Roxo claro
      case 'pântanos e manguezais':
        return const Color(0xFFE0F2F1); // Verde água claro
      case 'savanas':
        return const Color(0xFFFFEBEE); // Vermelho claro
      default:
        return Colors.grey[200]!;
    }
  }

  Color _obterCorBorda(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'florestas':
        return const Color(0xFF4CAF50); // Verde
      case 'desertos':
        return const Color(0xFFFF9800); // Laranja
      case 'oceanos e mares':
        return const Color(0xFF2196F3); // Azul
      case 'tundras':
        return const Color(0xFF9C27B0); // Roxo
      case 'pântanos e manguezais':
        return const Color(0xFF009688); // Verde água
      case 'savanas':
        return const Color(0xFFE91E63); // Rosa
      default:
        return Colors.grey;
    }
  }
}
