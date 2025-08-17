import 'dart:js_interop';

import 'package:equatable/equatable.dart';

/// Represents a tick mark on an axis.
class AxisTick extends Equatable {
  const AxisTick({required this.value, required this.label});

  final double value;
  final String? label;

  JSAxisTick get toJS => JSAxisTick(v: value, label: label);

  @override
  List<Object?> get props => [value, label];
}

extension type JSAxisTick._(JSObject object) implements JSObject {
  external factory JSAxisTick({required double v, required String? label});
}
