import 'package:agrocheck/data/unidade/unidade_api_service.dart';
import 'package:agrocheck/interactor/unidade/unidade_model.dart';
import 'package:agrocheck/interactor/unidade/unidade_state.dart';
import 'package:flutter/material.dart';

abstract class UnidadeStoreInterface {
  Future<void> fetchUnidades();
  Future<void> addUnidade(UnidadeModel unidade);
  Future<void> updateUnidade(UnidadeModel unidade);
  Future<void> deleteUnidade(UnidadeModel unidade);
}

class UnidadeStoreImpl extends ChangeNotifier implements UnidadeStoreInterface {
  final service = UnidadeService();
  var state = UnidadeState.newState();
  var unidades = <UnidadeModel>[];
  
    
  @override
  Future<void> fetchUnidades() async {
    state = state.copyWith(isLoading: true);
    try {
      unidades = await service.getUnidades();
      state = state.copyWith(unidades: unidades, isLoading: false);
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Failed to fetch unidades: $error');
      state = state.copyWith(error: error.toString(), isLoading: false);
      notifyListeners();
    }
  }

  @override
  Future<void> addUnidade(UnidadeModel unidade) async {
    state = state.copyWith(isLoading: true);
    try {
      await service.addUnidade(unidade);
      unidades = await service.getUnidades(); // Busque novamente a lista de unidades
      state = state.copyWith(unidades: unidades, isLoading: false);
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Failed to add unidade: $error');
      state = state.copyWith(error: error.toString(), isLoading: false);
      notifyListeners();
    }
  }

  @override
  Future<void> updateUnidade(UnidadeModel unidade) async {
    state = state.copyWith(isLoading: true);
    try {
      await service.updateUnidade(unidade);
        unidades = await service.getUnidades();
        state = state.copyWith(unidades: unidades, isLoading: false);
        notifyListeners();
    } catch (error) {
      // Handle error
      print('Failed to update unidade: $error');
      notifyListeners();
    }
  }

  @override
  Future<void> deleteUnidade(UnidadeModel unidade) async {
    state = state.copyWith(isLoading: true);
    try {
      await service.deleteUnidade(unidade);
      unidades = await service.getUnidades();
      state = state.copyWith(unidades: unidades, isLoading: false);
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Failed to delete unidade: $error');
      notifyListeners();
    }
  }
}