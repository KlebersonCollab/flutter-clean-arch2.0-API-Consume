import 'package:agrocheck/src/interactor/unidade/unidade_model.dart';

class UnidadeState{
  final bool isLoading;
  final String error;
  final List<UnidadeModel> unidades;

  UnidadeState({
    required this.isLoading,
    required this.error,
    required this.unidades,
  });
  factory UnidadeState.newState() {
    return UnidadeState(
      isLoading: false,
      error: '',
      unidades: [],
    );
  }

  UnidadeState copyWith({
    bool? isLoading,
    String? error,
    List<UnidadeModel>? unidades,
  }) {
    return UnidadeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      unidades: unidades ?? this.unidades,
    );
  }
}