import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/graph_configuration/graph_configuration.dart';

/// Describes the drawing area of [GraphConfiguration.underlayCallback]
class Area extends Equatable {
  const Area({required this.x, required this.y, required this.h, required this.w});

  final double x;
  final double y;
  final double h;
  final double w;

  @override
  List<Object> get props => [x, y, h, w];
}

extension type JSArea._(JSObject _) implements JSObject {
  external factory JSArea({
    required double x,
    required double y,
    required double h,
    required double w,
  });

  external double get x;
  external double get y;
  external double get h;
  external double get w;

  Area get toDart => Area(x: x, y: y, h: h, w: w);
}
