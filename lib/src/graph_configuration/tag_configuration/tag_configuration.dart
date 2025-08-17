import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/graph_configuration/tag_configuration/tag_click_handler.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// Configuration for tags drawn on the graph's canvas.
///
/// Tags are drawn in the shape of rectangle (tag) on top of a stick (pin).
class TagConfiguration extends Equatable {
  const TagConfiguration({
    required this.xValue,
    required this.color,
    required this.backgroundColor,
    this.text = '\uf129',
    this.font = '900 16px "Font Awesome 6 Free"',
    this.tagHeight = 22,
    this.tagWidth = 22,
    this.pinHeight = 7,
    this.pinWidth = 1,
    this.onTap,
  });

  /// The value along the x-axis at which the tag will be centered.
  final double xValue;

  /// The color to use for [text].
  final Color color;

  /// The color of the tag and pin that [text] will be drawn on.
  final Color backgroundColor;

  /// The text to be drawn on the tag using {ctx.fillText()}
  /// Default value represents the unicode for info icon from font awesome's free collection (fa-info)
  final String text;

  /// The font to be used for the text drawn on the tag.
  /// Defaults to 900 weight 16px Font Awesome 6 Free to allow unicode icons to work
  final String font;

  /// The height of the rectangular tag in pixels
  final double tagHeight;

  /// The width of the rectangular tag in pixels
  final double tagWidth;

  /// The height of the pin that connects the tag to the base of the graph in pixels
  final double pinHeight;

  /// The width of the pin that connects the tag to the base of the graph in pixels
  final double pinWidth;

  /// Called when this tag is clicked/tapped.
  final TagClickHandler? onTap;

  JSTagConfiguration get toJS => JSTagConfiguration(
    xValue: xValue,
    color: color.toCSS,
    backgroundColor: backgroundColor.toCSS,
    text: text,
    font: font,
    tagHeight: tagHeight,
    tagWidth: tagWidth,
    pinHeight: pinHeight,
    pinWidth: pinWidth,
    onTap: onTap == null ? null : createJSInteropWrapper(TagClickHandlerWrapper(onTap!)),
  );

  @override
  List<Object?> get props => [
    xValue,
    color,
    backgroundColor,
    text,
    font,
    tagHeight,
    tagWidth,
    pinHeight,
    pinWidth,
    onTap,
  ];
}

extension type JSTagConfiguration._(JSObject _) implements JSObject {
  external factory JSTagConfiguration({
    required double xValue,
    required String color,
    required String backgroundColor,
    required String text,
    required String font,
    required double tagHeight,
    required double tagWidth,
    required double pinHeight,
    required double pinWidth,
    required JSAny? onTap,
  });
}
