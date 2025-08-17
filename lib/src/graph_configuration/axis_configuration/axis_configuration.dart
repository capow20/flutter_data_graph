import 'dart:js_interop';
import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/graph_configuration/axis_configuration/axis_label_formatter.dart';
import 'package:flutter_data_graph/src/graph_configuration/axis_configuration/axis_tick.dart';
import 'package:flutter_data_graph/src/graph_configuration/axis_configuration/axis_ticker.dart';
import 'package:flutter_data_graph/src/graph_configuration/axis_configuration/axis_value_formatter.dart';
import 'package:flutter_data_graph/src/graph_configuration/graph_configuration.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// Used to set per-axis configuration settings.
///
/// Will override global settings such as [GraphConfiguration.valueFormatter] for this axis.
class AxisConfiguration extends Equatable {
  const AxisConfiguration({
    //! ===== Formatters ===== //
    this.ticker,
    this.labelFormatter,
    this.valueFormatter,
    //! ===== Labels ===== //
    this.axisLabelFontSize = 14,
    this.axisLabelColor = Colors.black,
    this.axisLabelWidth = 50,
    //! ===== Axis Lines ===== //
    this.axisLineColor = Colors.black,
    this.axisLineWidth = 0.3,
    //! ===== Grid Lines ===== //
    this.gridLineColor = const Color.fromRGBO(128, 128, 128, 1),
    this.gridLinePattern,
    this.gridLineWidth = 0.3,
  });

  factory AxisConfiguration.withIncrement({
    required double increment,
    AxisLabelFormatter? labelFormatter,
    AxisValueFormatter? valueFormatter,
    double axisLabelFontSize = 14,
    Color axisLabelColor = Colors.black,
    double axisLabelWidth = 50,
    Color axisLineColor = Colors.black,
    double axisLineWidth = 0.3,
    Color gridLineColor = const Color.fromRGBO(128, 128, 128, 1),
    List<int>? gridLinePattern,
    double gridLineWidth = 0.3,
  }) => AxisConfiguration(
    ticker: (a, b, _) => _incrementTicker(a: a, b: b, inc: increment, formatter: labelFormatter),
    labelFormatter: labelFormatter,
    valueFormatter: valueFormatter,
    axisLabelFontSize: axisLabelFontSize,
    axisLabelColor: axisLabelColor,
    axisLabelWidth: axisLabelWidth,
    axisLineColor: axisLineColor,
    axisLineWidth: axisLineWidth,
    gridLineColor: gridLineColor,
    gridLinePattern: gridLinePattern,
    gridLineWidth: gridLineWidth,
  );

  final List<AxisTick> Function(num, num, num)? ticker;

  /// Used to format the values shown in hover labels for this axis.
  final AxisLabelFormatter? labelFormatter;

  /// Used to format the values shown in the hover labels for each data point.
  final AxisValueFormatter? valueFormatter;

  /// The font size (in pixels) to use for the labels on this axis.
  final double axisLabelFontSize;

  /// The text color to use for the labels on this axis.
  final Color axisLabelColor;

  /// The width (in pixels) of the <div> that the labels on this axis will be placed inside.
  final double axisLabelWidth;

  /// The color this axis's line will be drawn with.
  final Color axisLineColor;

  /// The width (in pixels) of this axis's line.
  final double axisLineWidth;

  /// The color this axis's grid lines with be drawn with.
  final Color gridLineColor;

  /// The pattern this axis's grid lines will be drawn with. Used for drawing dotted lines.
  ///
  /// Values at even indices represent draw lengths in pixels.
  /// Values at odd indices represent gap (whitespace) lengths in pixels.
  final List<int>? gridLinePattern;

  /// The width (in pixels) of this axis' grid lines
  final double gridLineWidth;

  JSAxisConfiguration get toJS => JSAxisConfiguration(
    ticker: ticker == null ? null : createJSInteropWrapper(AxisTickerWrapper(ticker!)),
    labelFormatter: labelFormatter == null ? null : createJSInteropWrapper(AxisLabelFormatterWrapper(labelFormatter!)),
    valueFormatter: valueFormatter == null ? null : createJSInteropWrapper(AxisValueFormatterWrapper(valueFormatter!)),
    axisLabelFontSize: axisLabelFontSize,
    axisLabelColor: axisLabelColor.toCSS,
    axisLabelWidth: axisLabelWidth,
    axisLineColor: axisLineColor.toCSS,
    axisLineWidth: axisLineWidth,
    gridLineColor: gridLineColor.toCSS,
    gridLinePattern: gridLinePattern?.map((e) => e.toJS).toList().toJS,
    gridLineWidth: gridLineWidth,
  );

  /// A simple ticker method that will produce ticks at every multiple of [inc]
  static List<AxisTick> _incrementTicker({
    required num a,
    required num b,
    required double inc,
    AxisLabelFormatter? formatter,
  }) {
    final List<AxisTick> ticks = [];

    final double min = (math.min(a, b) / inc).floorToDouble() * inc;
    final double max = (math.max(a, b) / inc).ceilToDouble() * inc;

    for (double i = min; i <= max; i = i + inc) {
      final v = double.parse(i.toStringAsFixed(4));
      ticks.add(AxisTick(value: v, label: formatter?.call(v) ?? v.toString()));
    }

    return ticks;
  }

  @override
  List<Object?> get props => [valueFormatter, labelFormatter];
}

extension type JSAxisConfiguration._(JSObject _) implements JSObject {
  external factory JSAxisConfiguration({
    required JSObject? ticker,
    required JSObject? labelFormatter,
    required JSObject? valueFormatter,
    required double axisLabelFontSize,
    required String axisLabelColor,
    required double axisLabelWidth,
    required String axisLineColor,
    required double axisLineWidth,
    required String gridLineColor,
    required JSArray<JSNumber>? gridLinePattern,
    required double gridLineWidth,
  });
}
