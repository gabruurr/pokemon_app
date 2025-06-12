import 'package:equatable/equatable.dart';
import '../models/movement.dart';
import '../models/pokemon.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  final List<Movement> movements;

  const PokemonLoaded(this.pokemons, this.movements);

  @override
  List<Object?> get props => [pokemons, movements];
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object?> get props => [message];
}

class PokemonOperationFailure extends PokemonState {
  final String message;

  const PokemonOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}