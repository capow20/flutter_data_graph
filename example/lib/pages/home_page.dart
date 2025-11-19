import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_data_graph/flutter_data_graph.dart';
import 'package:flutter_data_graph_app/cubit/graph_data_cubit.dart';
import 'package:flutter_data_graph_app/widgets/atoms/tag_modal.dart';

const Map<String, List<String>> iconFlags = {
  '\u0058': ['Crossing'],
  '\ue59a': ['Fence'],
  '\uf0e7': ['Skip'],
  '\uf072': ['Aerial'],
  '\uf0c1': ['Station'],
};

String getCommentIcon(String comment) {
  final Map<String, int> matches = {};

  for (final entry in iconFlags.entries) {
    for (int i = 0; i < entry.value.length; i++) {
      final index = comment.toUpperCase().indexOf(entry.value[i].toUpperCase());
      if (index == -1) continue;
      matches[entry.key] = index;
    }
  }

  if (matches.isEmpty) return '\uf129';

  return matches.entries.reduce((a, b) => a.value < b.value ? a : b).key;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GraphController lineController;
  late GraphController barController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GraphDataCubit(),
      child: BlocBuilder<GraphDataCubit, GraphDataState>(
        builder: (context, state) {
          if (state.lineData.isEmpty) return const Center(child: CircularProgressIndicator());
          return Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Data Graph', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
            ),
            backgroundColor: Colors.grey.shade200,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: DataGraph(
                      data: state.lineData,
                      padding: const EdgeInsets.only(top: 10),
                      height: 400,
                      config: GraphConfiguration(
                        xLabel: 'Station',
                        minY: -1,
                        maxY: 1.5,
                        backgroundColor: Colors.grey.shade800,
                        legendConfig: LegendConfiguration(
                          backgroundColor: Colors.grey.shade800,
                          color: Colors.white,
                          border: '1px solid white',
                          borderRadius: '8px',
                        ),
                        yRangePad: 50,
                        yAxisConfig: AxisConfiguration.withIncrement(
                          increment: 0.25,
                          axisLabelColor: Colors.white,
                          axisLineColor: Colors.white,
                          gridLineColor: Colors.white,
                        ),
                        xAxisConfig: const AxisConfiguration(
                          axisLabelColor: Colors.white,
                          axisLineColor: Colors.white,
                          gridLineColor: Colors.white,
                        ),
                        valueFormatter: (p0, p1) => p0.toStringAsFixed(2),
                        series: const [
                          SeriesConfiguration(name: 'Sensor 1', color: Colors.red),
                          SeriesConfiguration(name: 'Sensor 2', color: Colors.red),
                          SeriesConfiguration(name: 'Sensor 1 - Cleaned', color: Colors.lightGreen),
                          SeriesConfiguration(name: 'Sensor 2 - Cleaned', color: Colors.lightBlue),
                        ],
                        tags: state.comments.entries.map((e) {
                          //final unicode = getCommentIcon(e.value);
                          return TagConfiguration(
                            xValue: e.key,
                            color: Colors.white,
                            backgroundColor: Colors.lightBlue,
                            //text: unicode,
                            text: '',
                            pinHeight: 0,
                            pinWidth: 0,
                            showTooltip: true,
                            tooltipHtml: e.value,
                            onTap: (v) {
                              showDialog<void>(
                                context: context,
                                builder: (context) => TagModal(
                                  station: e.key,
                                  comment: e.value,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      onGraphCreated: (c) => lineController = c,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: DataGraph(
                      data: state.barData,
                      padding: const EdgeInsets.only(top: 10),
                      height: 200,
                      config: GraphConfiguration(
                        xLabel: 'Station',
                        backgroundColor: Colors.grey.shade800,
                        legendConfig: LegendConfiguration(
                          backgroundColor: Colors.grey.shade800,
                          color: Colors.white,
                          border: '1px solid white',
                          borderRadius: '8px',
                        ),
                        yRangePad: 100,
                        yAxisConfig: AxisConfiguration.withIncrement(
                          increment: 10,
                          axisLabelWidth: 25,
                          axisLabelColor: Colors.white,
                          axisLineColor: Colors.white,
                          gridLineColor: Colors.white,
                        ),
                        xAxisConfig: const AxisConfiguration(
                          axisLabelColor: Colors.white,
                          axisLineColor: Colors.white,
                          gridLineColor: Colors.white,
                        ),
                        valueFormatter: (p0, p1) => p0.toStringAsFixed(2),
                        series: const [
                          SeriesConfiguration(name: 'Read', color: Colors.blue, plotterType: SeriesPlotterType.bar),
                        ],
                      ),
                      onGraphCreated: (c) => barController = c,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
