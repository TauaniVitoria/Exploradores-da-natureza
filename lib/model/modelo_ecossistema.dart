// modelo_ecossistema.dart

import 'package:flutter/material.dart';

class Ecossistema {
  final String id;
  final String nome;
  final String tipo;
  final String urlImagem;
  final String urlImagem2;
  final Color corFundo;
  final Color corBorda;
  final String localizacao;
  final String caracteristicas;
  final String nichoEcologico;
  final String cadeiaAlimentar;
  final String importanciaEcologica;
  final String ameacas;
  final String acoesConservacao;
  bool favorito;

  Ecossistema({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.urlImagem,
    required this.urlImagem2,
    required this.corFundo,
    required this.corBorda,
    required this.localizacao,
    required this.caracteristicas,
    required this.nichoEcologico,
    required this.cadeiaAlimentar,
    required this.importanciaEcologica,
    required this.ameacas,
    required this.acoesConservacao,
    this.favorito = false,
  });
}
