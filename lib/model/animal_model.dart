// animal_model.dart

import 'package:flutter/material.dart';

class Animal {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  //final String routeLink; // Nome da rota para navegar à tela do animal
  final Color backgroundColor; // Cor de fundo da imagem
  final Color borderColor; // Cor da borda da imagem
  bool isFavorite;

  Animal({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    //required this.routeLink,
    required this.backgroundColor,
    required this.borderColor,
    this.isFavorite = false,
  });
}

