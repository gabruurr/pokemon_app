import 'package:flutter/material.dart';

class TypeUtils {
  static String getSymbolForType(String type) {
    switch (type) {
      case 'Fogo':
        return '🔥';
      case 'Água':
        return '💧';
      case 'Planta':
        return '🍃';
      case 'Elétrico':
        return '⚡️';
      case 'Normal':
        return '⭐️';
      case 'Voador':
        return '🕊️';
      case 'Pedra':
        return '🗿';
      default:
        return '❓';
    }
  }

  static Color getColorForType(String type) {
    switch (type) {
      case 'Fogo':
        return Colors.red.shade600;
      case 'Água':
        return Colors.blue.shade600;
      case 'Planta':
        return Colors.green.shade600;
      case 'Elétrico':
        return Colors.amber.shade700;
      case 'Normal':
        return Colors.grey.shade600;
      case 'Voador':
        return Colors.lightBlue.shade300;
      case 'Pedra':
        return Colors.brown.shade600;
      default:
        return Colors.black;
    }
  }
}