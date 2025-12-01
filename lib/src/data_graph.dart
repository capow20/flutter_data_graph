import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/graph_configuration/graph_configuration.dart';
import 'package:flutter_data_graph/src/util/graph_controller.dart';

class DataGraph extends StatefulWidget {
  const DataGraph({
    super.key,
    required this.data,
    required this.config,
    this.onGraphCreated,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior,
  });
  final List<List<num?>> data;
  final GraphConfiguration config;
  final void Function(GraphController)? onGraphCreated;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final Clip? clipBehavior;

  @override
  State<DataGraph> createState() => _DataGraphState();
}

class _DataGraphState extends State<DataGraph> {
  late final GraphController _controller = GraphController(data: widget.data, config: widget.config);

  @override
  void initState() {
    widget.onGraphCreated?.call(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DataGraph old) {
    _controller
      ..updateData(data: widget.data)
      ..updateConfig(config: widget.config);
    super.didUpdateWidget(old);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      margin: widget.margin,
      decoration: widget.decoration,
      clipBehavior: widget.decoration != null ? widget.clipBehavior ?? Clip.hardEdge : Clip.none,
      child: _controller.graph,
    );
  }
}
