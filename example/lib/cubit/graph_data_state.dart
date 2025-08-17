part of 'graph_data_cubit.dart';

class GraphDataState extends Equatable {
  const GraphDataState({
    this.data = const [],
    this.comments = const {},
  });

  final List<List<double>> data;
  final Map<double, String> comments;

  GraphDataState copyWith({
    List<List<double>>? data,
    Map<double, String>? comments,
  }) {
    return GraphDataState(
      data: data ?? this.data,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object> get props => [
    data,
    comments,
  ];
}
