import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../models/pokemon.dart';

class FormScreen extends StatefulWidget {
  final Pokemon? pokemon;

  const FormScreen({super.key, this.pokemon});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  String _tipoSelecionado = 'Fogo';
  late String _selectedImageAsset;

  final List<String> _availableImages = [
    'assets/images/p1.png',
    'assets/images/p2.png',
    'assets/images/p3.png',
    'assets/images/p4.png',
    'assets/images/p5.png',
    'assets/images/p6.png',
  ];

  final List<String> _tipos = [
    'Fogo',
    'Água',
    'Planta',
    'Elétrico',
    'Normal',
    'Voador',
    'Pedra',
  ];

  final List<String> _randomNames = [
    'Ratinho',
    'Cabeça quente',
    'Fofinho',
    'Sparky',
    'Zappy',
    'Gusty',
    'Terra',
    'Wisp',
    'Bolt',
    'Vegan'
  ];

  @override
  void initState() {
    super.initState();

    if (widget.pokemon != null) {
      _nomeController = TextEditingController(text: widget.pokemon!.nome);
      _tipoSelecionado = widget.pokemon!.tipo;
      _selectedImageAsset = widget.pokemon!.imageAsset;
    } else {
      final random = Random();
      _nomeController = TextEditingController(
          text: _randomNames[random.nextInt(_randomNames.length)]);
      _tipoSelecionado = _tipos[random.nextInt(_tipos.length)];
      _selectedImageAsset =
          _availableImages[random.nextInt(_availableImages.length)];
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final novoPokemon = Pokemon(
        id: widget.pokemon?.id,
        nome: _nomeController.text,
        tipo: _tipoSelecionado,
        imageAsset: _selectedImageAsset,
        estaNaEquipe: widget.pokemon?.estaNaEquipe ?? false,
      );

      final bloc = context.read<PokemonBloc>();
      if (widget.pokemon == null) {
        bloc.add(AddPokemon(novoPokemon));
      } else {
        bloc.add(UpdatePokemon(novoPokemon));
      }

      Navigator.pop(context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Placeholder();
  }
}
