import 'package:equatable/equatable.dart';
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

  const PokemonLoaded(this.pokemons);

  @override
  List<Object?> get props => [pokemons];
}
