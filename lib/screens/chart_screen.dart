import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pokemon_app/models/movement.dart';

import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_state.dart';
import '../models/pokemon.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int _selectedViewIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Placeholder();
  }
}
