import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/util/graph_controller.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// Configuration for a custom circle drawn on the graph.
///
/// Utilized by [GraphController.circlePoint]
class CircleConfiguration extends Equatable {
  const CircleConfiguration({
    this.radius = 5,
    this.fillColor,
    this.strokeColor = Colors.black,
    this.strokeWidth = 1,
    this.strokePattern = const [],
  }) : assert(fillColor != null || strokeColor != null, 'Either fill color or stroke color must be provided.');

  /// The radius of the circle to be drawn.
  final double radius;

  /// The fill color of the circle.
  ///
  /// If left null, no fill will be drawn.
  final Color? fillColor;

  /// The stroke color of the circle.
  ///
  /// The set to null, no stroke will be drawn.
  final Color? strokeColor;

  /// The width of the stroke line.
  final double strokeWidth;

  /// The pattern circle's stroke line will be drawn with. Used for drawing dotted lines.
  ///
  /// Values at even indices represent draw lengths in pixels.
  /// Values at odd indices represent gap (whitespace) lengths in pixels.
  final List<int> strokePattern;

  JSCircleConfiguration get toJS => JSCircleConfiguration(
    radius: radius,
    fillColor: fillColor?.toCSS,
    strokeColor: strokeColor?.toCSS,
    strokeWidth: strokeWidth,
    strokePattern: strokePattern.map((e) => e.toJS).toList().toJS,
  );

  @override
  List<Object?> get props => [radius, fillColor, strokeColor, strokeWidth, strokePattern];
}

extension type JSCircleConfiguration._(JSObject _) implements JSObject {
  external factory JSCircleConfiguration({
    required double radius,
    required String? fillColor,
    required String? strokeColor,
    required double strokeWidth,
    required JSArray<JSNumber> strokePattern,
  });
}
