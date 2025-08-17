import 'dart:js_interop';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// Configuration for an extra line drawn on the graph.
class ExtraLineConfiguration extends Equatable {
  const ExtraLineConfiguration({
    required this.yValue,
    required this.color,
    this.strokeWidth = 1,
    this.strokePattern = const [],
  });

  /// The y-value to draw the line at
  final double yValue;

  /// The color the line will be drawn with
  final Color color;

  /// The thickness of the line
  final double strokeWidth;

  /// The pattern this line will be drawn with. Used for drawing dotted lines.
  ///
  /// Values at even indices represent draw lengths in pixels.
  /// Values at odd indices represent gap (whitespace) lengths in pixels.
  final List<int> strokePattern;

  JSExtraLineConfiguration get toJS => JSExtraLineConfiguration(
    yValue: yValue,
    color: color.toCSS,
    strokeWidth: strokeWidth,
    strokePattern: strokePattern.map((e) => e.toJS).toList().toJS,
  );

  @override
  List<Object> get props => [yValue, color, strokeWidth, strokePattern];
}

extension type JSExtraLineConfiguration._(JSObject _) implements JSObject {
  external factory JSExtraLineConfiguration({
    required double yValue,
    required String color,
    required double strokeWidth,
    required JSArray<JSNumber> strokePattern,
  });
}
