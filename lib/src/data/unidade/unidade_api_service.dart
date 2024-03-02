import 'dart:convert';
import 'package:agrocheck/src/interactor/unidade/unidade_model.dart';
import 'package:http/http.dart' as http;


class UnidadeService {
  Future<List<UnidadeModel>> getUnidades() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/v1/unidades/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((item) => UnidadeModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load unidades');
    }
  }
  Future<void> addUnidade(UnidadeModel unidade) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/v1/unidades/'),
      body: jsonEncode(unidade.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add unidade');
    }
  }
  Future<void> updateUnidade(UnidadeModel unidade) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/v1/unidades/${unidade.id}/'),
      body: jsonEncode(unidade.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update unidade');
    }
  }
  Future<void> deleteUnidade(UnidadeModel unidade) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/v1/unidades/${unidade.id}/'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete unidade');
    }
  }

}