import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/graph_configuration/graph_configuration.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// Represents a series of data.
///
/// Provides customization options for the given series.
class SeriesConfiguration extends Equatable {
  const SeriesConfiguration({
    required this.name,
    required this.color,
    this.strokeWidth = 1.0,
    this.strokeBorderWidth,
    this.strokeBorderColor = Colors.white,
    this.strokePattern,
    this.drawPoints = false,
    this.pointSize = 1,
    this.highlightCircleSize = 3,
  });

  /// Simple factory to remove the requirement for name and color.
  ///
  /// Intended for use with [GraphConfiguration.highlightSeriesOpts]
  factory SeriesConfiguration.highlight({
    double? strokeWidth,
    double? strokeBorderWidth,
    Color? strokeBorderColor,
    List<int>? strokePattern,
    bool? drawPoints,
    double? pointSize,
    double? highlightCircleSize,
  }) => SeriesConfiguration(
    name: '',
    color: Colors.black,
    strokeWidth: strokeWidth ?? 1.0,
    strokeBorderWidth: strokeBorderWidth,
    strokeBorderColor: strokeBorderColor ?? Colors.white,
    strokePattern: strokePattern,
    drawPoints: drawPoints ?? false,
    pointSize: pointSize ?? 1,
    highlightCircleSize: highlightCircleSize ?? 3,
  );

  /// The name of the series.
  final String name;

  /// The color of the series's line.
  final Color color;

  /// The stroke width of the series's line.
  final double strokeWidth;

  /// The width of the border on this series's line.
  final double? strokeBorderWidth;

  /// The color of the border on this series's line.
  final Color strokeBorderColor;

  /// The pattern this series's line will be drawn with. Used for drawing dotted lines.
  ///
  /// Values at even indices represent draw lengths in pixels.
  /// Values at odd indices represent gap (whitespace) lengths in pixels.
  final List<int>? strokePattern;

  /// Whether or not a dot should be drawn at each point
  final bool drawPoints;

  /// The size of the dot to draw on each point if [drawPoints] is true.AboutDialog
  ///
  /// Points are always drawn if data is missing on either side of a point.
  final double pointSize;

  /// The size of the dot drawn over a point when highlighted, in pixels.
  final double highlightCircleSize;

  JSSeriesConfiguration get toJS => JSSeriesConfiguration(
    name: name,
    color: color.toCSS,
    strokeWidth: strokeWidth,
    strokeBorderWidth: strokeBorderWidth,
    strokeBorderColor: strokeBorderColor.toCSS,
    strokePattern: strokePattern?.map((e) => e.toJS).toList().toJS,
    drawPoints: drawPoints,
    pointSize: pointSize,
    highlightCircleSize: highlightCircleSize,
  );

  @override
  List<Object?> get props => [
    name,
    color,
    strokeWidth,
    strokeBorderWidth,
    strokeBorderColor,
    strokePattern,
    drawPoints,
    pointSize,
    highlightCircleSize,
  ];
}

extension type JSSeriesConfiguration._(JSObject _) implements JSObject {
  external factory JSSeriesConfiguration({
    required String name,
    required String color,
    required double strokeWidth,
    required double? strokeBorderWidth,
    required String strokeBorderColor,
    required JSArray<JSNumber>? strokePattern,
    required bool drawPoints,
    required double pointSize,
    required double highlightCircleSize,
  });
}
