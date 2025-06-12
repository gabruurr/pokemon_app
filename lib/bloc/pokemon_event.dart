import 'package:equatable/equatable.dart';
import '../models/pokemon.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

class LoadPokemons extends PokemonEvent {}

class AddPokemon extends PokemonEvent {
  final Pokemon pokemon;

  const AddPokemon(this.pokemon);

  @override
  List<Object?> get props => [pokemon];
}

class UpdatePokemon extends PokemonEvent {
  final Pokemon pokemon;

  const UpdatePokemon(this.pokemon);

  @override
  List<Object?> get props => [pokemon];
}

class DeletePokemon extends PokemonEvent {
  final int id;

  const DeletePokemon(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleEquipeStatus extends PokemonEvent {
  final Pokemon pokemon;

  const ToggleEquipeStatus(this.pokemon);

  @override
  List<Object?> get props => [pokemon];
}