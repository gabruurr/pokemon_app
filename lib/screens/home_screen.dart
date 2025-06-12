import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/screens/form_screen.dart';

import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../bloc/pokemon_state.dart';
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

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playClickSound() {
    _audioPlayer.play(AssetSource('audios/sound.mp3'));
  }

  void _stopSound() {
    _audioPlayer.stop();
  }

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
    return BlocListener<PokemonBloc, PokemonState>(
      listener: (context, state) {
        if (state is PokemonOperationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitles[_selectedIndex]),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Recarregar',
              onPressed: () => context.read<PokemonBloc>().add(LoadPokemons()),
            ),
          ],
        ),
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PokemonLoaded) {
              final equipe =
                  state.pokemons.where((p) => p.estaNaEquipe).toList();
              final pc = state.pokemons.where((p) => !p.estaNaEquipe).toList();

              final List<Widget> screens = [
                _buildPokemonListView(equipe),
                _buildPokemonListView(pc),
                const Placeholder(),
              ];

              return screens[_selectedIndex];
            }
            if (state is PokemonError) {
              return Center(child: Text('Erro: ${state.message}'));
            }
            return const Center(child: Text('Nenhum Pokémon encontrado.'));
          },
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FormScreen()),
                  );
                },
                tooltip: 'Capturar Pokemon',
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon),
              label: 'Equipe',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.computer), label: 'PC'),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Gráfico',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            _stopSound();
            _playClickSound();

            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}