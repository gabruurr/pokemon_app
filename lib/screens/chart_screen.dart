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



Widget _buildTimelineView(List<Movement> movements) {
    if (movements.isEmpty) {
      return const Center(
        child: Text('Nenhuma movimentação registrada.',
            style: TextStyle(fontSize: 18)),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(6),
      itemCount: movements.length,
      itemBuilder: (context, index) {
        final movement = movements[index];
        final bool paraEquipe = movement.movedTo == 'Equipe';
        final theme = Theme.of(context);
        final formattedDate = DateFormat('dd/MM/yyyy \'às\' HH:mm', 'pt_BR')
            .format(movement.timestamp);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              spacing: 8,
              children: [
                Image.asset(movement.pokemonImageAsset, width: 50, height: 50),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: movement.pokemonName,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: ' foi movido para a ',
                                style: theme.textTheme.titleMedium),
                            TextSpan(
                              text: movement.movedTo,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: paraEquipe
                                    ? Colors.green.shade700
                                    : Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Icon(
                  paraEquipe
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: paraEquipe ? Colors.green.shade700 : Colors.blueGrey,
                  size: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
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
