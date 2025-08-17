import 'package:flutter/material.dart';
import 'package:flutter_data_graph/flutter_data_graph.dart';
import 'package:flutter_data_graph_app/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Graph',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.red,
          onPrimary: Colors.white,
          secondary: Colors.grey.shade500,
          onSecondary: Colors.white,
          error: Colors.red.shade700,
          onError: Colors.white,
          surface: const Color.fromRGBO(245, 245, 244, 1),
          onSurface: Colors.black,
        ),
      ),
      home: const HomePage(),
    );
  }
}

/// A minimal numeric example
class MyGraphPage extends StatelessWidget {
  const MyGraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    final data = <List<num>>[
      [0, 5],
      [1, 8],
      [2, 6],
      [3, 10],
      [4, 7],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Data Graph', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: DataGraph(
          height: s.height * 0.75,
          width: s.width * 0.75,
          data: data,
          config: const GraphConfiguration(
            xLabel: 'Index',
            series: [
              SeriesConfiguration(
                name: 'My Series',
                color: Color(0xFF2196F3),
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
