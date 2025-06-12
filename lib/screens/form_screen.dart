import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../core/utils/type_utills.dart';
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
    final isEdicao = widget.pokemon != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdicao ? 'Editar Pokémon' : 'Capturar Pokémon'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome do Pokémon'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              DropdownButtonFormField<String>(
                value: _tipoSelecionado,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: _tipos.map((tipo) {
                  final symbol = TypeUtils.getSymbolForType(tipo);
                  return DropdownMenuItem(
                    value: tipo,
                    child: Text(
                      '$symbol  $tipo',
                    ),
                  );
                }).toList(),
                onChanged: (valor) {
                  setState(() => _tipoSelecionado = valor!);
                },
              ),
              const Text('Imagem do Pokémon', style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableImages.length,
                  separatorBuilder: (_, __) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3)),
                  itemBuilder: (context, index) {
                    final image = _availableImages[index];
                    final isSelected = image == _selectedImageAsset;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedImageAsset = image),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : const Color.fromARGB(255, 91, 90, 90),
                            width: isSelected ? 3 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(image),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _salvar,
                child: Text(isEdicao ? 'Atualizar' : 'Capturar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}