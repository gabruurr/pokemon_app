import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/database/pokemon_database.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonDatabase database;

  PokemonBloc({required this.database}) : super(PokemonLoading()) {
    on<LoadPokemons>(_onLoadPokemons);
    on<AddPokemon>(_onAddPokemon);
    on<UpdatePokemon>(_onUpdatePokemon);
    on<DeletePokemon>(_onDeletePokemon);
    on<ToggleEquipeStatus>(_onToggleStatus);
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

  Future<void> _onUpdatePokemon(
      UpdatePokemon event, Emitter<PokemonState> emit) async {
    if (state is PokemonLoaded) {
      await database.updatePokemon(event.pokemon);
      add(LoadPokemons());
    }
  }

  Future<void> _onDeletePokemon(
      DeletePokemon event, Emitter<PokemonState> emit) async {
    if (state is PokemonLoaded) {
      await database.deletePokemon(event.id);

      add(LoadPokemons());
    }
  }

  Future<void> _onToggleStatus(
      ToggleEquipeStatus event, Emitter<PokemonState> emit) async {
    if (state is PokemonLoaded) {
      final currentState = state as PokemonLoaded;
      final pokemon = event.pokemon;

      if (!pokemon.estaNaEquipe) {
        final equipe =
            currentState.pokemons.where((p) => p.estaNaEquipe).toList();

        if (equipe.length >= 6) {
          emit(PokemonOperationFailure('A equipe já está cheia! (Máx. 6)'));

          emit(PokemonLoaded(currentState.pokemons));
          return;
        }
      }

      final atualizado = pokemon.copyWith(estaNaEquipe: !pokemon.estaNaEquipe);
      await database.updatePokemon(atualizado);

      add(LoadPokemons());
    }
  }
}