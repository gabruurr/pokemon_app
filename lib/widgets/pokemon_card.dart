import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';
import '../core/utils/type_utills.dart';
import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PokemonBloc>();

    final typeSymbol = TypeUtils.getSymbolForType(pokemon.tipo);
    final typeColor = TypeUtils.getColorForType(pokemon.tipo);

    return Card();
  }

 Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return IconButton(
      icon: Icon(icon, size: 20),
      color: color ?? Theme.of(context).colorScheme.primary,
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}