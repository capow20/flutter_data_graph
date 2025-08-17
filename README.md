A Flutter package that brings [Dygraph.js](http://dygraphs.com/) line graphs into your Flutter apps via **Dart/JS interop**.  
It provides a **Flutter-friendly API** for building interactive, high-performance numeric line charts without writing JavaScript yourself.

---

## ✨ Features

- 📈 Interactive line graphs powered by **Dygraph.js**
- 🎨 Dart-first configuration objects (`GraphConfiguration`, `SeriesConfiguration`, `AxisConfiguration`, etc.)
- 🔍 Mouseover highlighting, zooming, and panning
- 🏷️ Legends, custom tags, and extra horizontal lines
- 🎯 Rich callback support (click, zoom, highlight, underlay drawing, etc.)
- 🌐 Optimized for **Flutter Web**
- 🔢 **Numeric-only** datasets (see Limitations)

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_data_graph: ^0.0.1
```

Then run:

```sh
flutter pub get
```

---

## 🚀 Getting Started

Minimal example using **numeric data**:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/flutter_data_graph.dart';

class MyGraphPage extends StatelessWidget {
  const MyGraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = <List<num>>[
      [0, 5],
      [1, 8],
      [2, 6],
      [3, 10],
      [4, 7],
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Data Graph Example')),
      body: Center(
        child: DataGraph(
          data: data,
          config: GraphConfiguration(
            xLabel: 'Index',
            series: [
              SeriesConfiguration(
                name: 'My Series',
                color: '#2196f3',
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🧩 Example: Reference Line & Zoom Callback

```dart
final config = GraphConfiguration(
    xLabel: 'X',
    minY: 0,
    maxY: 15,
    series: const [
        SeriesConfiguration(
        name: 'Sensor A',
        color: Color(0xFFFF5722),
        strokeWidth: 2,
        ),
    ],
    extraLines: const [
        ExtraLineConfiguration(
        yValue: 8,
        color: Color(0xFF00C853),
        strokeWidth: 2,
        strokePattern: [20, 20],
        ),
    ],
    zoomCallback: (minX, maxX, ranges) {
        debugPrint('Zoomed to: $ranges');
    },
);
```

---

## 🛠️ Contributing

Contributions are welcome! Feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (git checkout -b feature/amazing-feature)
3. Commit your changes (git commit -m 'Add some amazing feature')
4. Push to the branch (git push origin feature/amazing-feature)
5. Open a Pull Request

---

## 📜 License

MIT License. See [LICENSE](LICENSE) for details.

---

## 🙌 Acknowledgements

- Built on top of the excellent [Dygraph.js](http://dygraphs.com/).