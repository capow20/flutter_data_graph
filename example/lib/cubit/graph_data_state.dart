part of 'graph_data_cubit.dart';

class GraphDataState extends Equatable {
  const GraphDataState({
    this.lineData = const [],
    this.barData = const [],
    this.comments = const {},
  });

  final List<List<double>> lineData;
  final List<List<double>> barData;
  final Map<double, String> comments;

  GraphDataState copyWith({
    List<List<double>>? lineData,
    List<List<double>>? barData,

    Map<double, String>? comments,
  }) {
    return GraphDataState(
      lineData: lineData ?? this.lineData,
      barData: barData ?? this.barData,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object> get props => [
    lineData,
    barData,
    comments,
  ];
}
