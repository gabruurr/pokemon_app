import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../core/utils/type_utills.dart';
import '../models/pokemon.dart';
import '../screens/form_screen.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PokemonBloc>();

    final typeSymbol = TypeUtils.getSymbolForType(pokemon.tipo);
    final typeColor = TypeUtils.getColorForType(pokemon.tipo);

    return Card(
      color: pokemon.estaNaEquipe
          ? const Color.fromARGB(255, 183, 212, 241)
          : Colors.grey.shade200,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pokemon.nome,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            Chip(
              avatar: Text(typeSymbol, style: const TextStyle(fontSize: 14)),
              label: Text(
                pokemon.tipo,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: typeColor,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.asset(
                  pokemon.imageAsset,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context: context,
                  icon: Icons.sync_alt,
                  tooltip: 'Mover',
                  onPressed: () => bloc.add(ToggleEquipeStatus(pokemon)),
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.edit,
                  tooltip: 'Editar',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FormScreen(pokemon: pokemon),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.catching_pokemon_rounded,
                  tooltip: 'Liberar',
                  color: Colors.red.shade700,
                  onPressed: () => bloc.add(DeletePokemon(pokemon.id!)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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