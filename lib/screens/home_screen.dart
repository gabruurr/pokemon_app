import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<String> _appBarTitles = [
    'Sua Equipe',
    'PC de Gabryel',
    'Gráficos',
  ];

  Widget _buildPokemonListView(List<Pokemon> pokemonList) {
    if (pokemonList.isEmpty) {
      return const Center(
        child: Text('Nenhum Pokémon aqui.', style: TextStyle(fontSize: 18)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2.5,
      ),
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        return Placeholder();
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Placeholder();
  }
}
