import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pokemon_app/models/movement.dart';

import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_state.dart';
import '../models/pokemon.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int _selectedViewIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Placeholder();
  }


Widget _buildPieChartView(List<Pokemon> pokemons) {
    final totalEquipe = pokemons.where((p) => p.estaNaEquipe).length;
    final totalPC = pokemons.where((p) => !p.estaNaEquipe).length;

    if (totalEquipe == 0 && totalPC == 0) {
      return const Center(
        child:
            Text('Nenhum Pokémon cadastrado.', style: TextStyle(fontSize: 18)),
      );
    }

    return PieChart(
      PieChartData(
        centerSpaceColor: const Color.fromARGB(255, 217, 214, 214),
        sections: [
          PieChartSectionData(
            color: const Color.fromARGB(255, 255, 255, 255),
            value: totalEquipe.toDouble(),
            title: 'Equipe ($totalEquipe)',
            radius: 80,
            titleStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          PieChartSectionData(
            color: const Color.fromARGB(255, 255, 3, 3),
            value: totalPC.toDouble(),
            title: 'PC ($totalPC)',
            radius: 80,
            titleStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
        sectionsSpace: 4,
        centerSpaceRadius: 60,
      ),
    );
  }

}
