import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'graph_data_state.dart';

class GraphDataCubit extends Cubit<GraphDataState> {
  GraphDataCubit() : super(const GraphDataState()) {
    loadGraphData();
  }

  Future<void> loadGraphData() async {
    final raw = List<Map<String, dynamic>>.from(
      jsonDecode(await rootBundle.loadString('assets/example_data.json')) as List<dynamic>,
    );

    final Map<double, String> remarks = {};
    final List<List<double>> formatted = raw.map((e) {
      if (e['Comments'] != null) {
        remarks[e['Station'] as double] = e['Comments'] as String;
      }
      return [
        e['Station'] as double,
        e['Sensor_1'] as double,
        e['Sensor_2'] as double,
        e['Sensor_1_Cleaned'] as double,
        e['Sensor_2_Cleaned'] as double,
      ];
    }).toList();

    emit(state.copyWith(data: formatted, comments: remarks));
  }
}
