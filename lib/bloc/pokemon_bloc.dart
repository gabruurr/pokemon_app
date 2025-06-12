import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/database/pokemon_database.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonDatabase database;

  PokemonBloc({required this.database}) : super(PokemonLoading()) {
    on<LoadPokemons>(_onLoadPokemons);
    on<AddPokemon>(_onAddPokemon);
    
  }

  Future<void> _onLoadPokemons(
      LoadPokemons event, Emitter<PokemonState> emit) async {
    emit(PokemonLoading());
    try {
      final pokemons = await database.getPokemons();
      emit(PokemonLoaded(pokemons));
    } catch (e) {
      emit(PokemonError('Erro ao carregar dados'));
    }
  }

  Future<void> _onAddPokemon(
      AddPokemon event, Emitter<PokemonState> emit) async {
    if (state is PokemonLoaded) {
      final currentState = state as PokemonLoaded;
      final equipe =
          currentState.pokemons.where((p) => p.estaNaEquipe).toList();

      final bool vaiParaEquipe = equipe.length < 6;
      final pokemonParaAdicionar =
          event.pokemon.copyWith(estaNaEquipe: vaiParaEquipe);

      await database.insertPokemon(pokemonParaAdicionar);
      add(LoadPokemons());
    }
  }

}