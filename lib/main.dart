import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pokemon_app/screens/home_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


import 'bloc/pokemon_bloc.dart';
import 'bloc/pokemon_event.dart';
import 'core/theme/app_theme.dart';
import 'data/database/pokemon_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await initializeDateFormatting('pt_BR', null);

  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PokemonBloc(database: PokemonDatabase.instance)..add(LoadPokemons()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokémon App',
        theme: AppTheme.theme,
        home: const HomeScreen(),
      ),
    );
  }
}