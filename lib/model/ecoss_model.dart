// Ecossistema_model.dart

import 'package:flutter/material.dart';

class Ecosystem {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final Color backgroundColor;
  final Color borderColor;
  bool isFavorite;

  Ecosystem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.backgroundColor,
    required this.borderColor,
    this.isFavorite = false,
  });
}

