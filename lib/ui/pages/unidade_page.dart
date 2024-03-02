// ignore_for_file: library_private_types_in_public_api, sort_child_properties_last

import 'package:agrocheck/interactor/unidade/unidade_model.dart';
import 'package:agrocheck/interactor/unidade/unidade_store.dart';
import 'package:flutter/material.dart';

class UnidadePage extends StatelessWidget {
  UnidadePage({super.key});
  final store = UnidadeStoreImpl();
  void _showUnidadeDialog(String title, UnidadeModel unidade, Function(UnidadeModel) onSave, context) async {
    final formKey = GlobalKey<FormState>();
    final unidadeController = TextEditingController(text: unidade.unidade);
    final siglaController = TextEditingController(text: unidade.sigla);
    bool isActive = unidade.active;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: unidadeController,
                  decoration: const InputDecoration(labelText: 'Unidade'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe a unidade';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: siglaController,
                  decoration: const InputDecoration(labelText: 'Sigla'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe a sigla';
                    }else
                    if (value.length > 3) {
                      return 'A sigla deve ter no máximo 3 caracteres';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  unidade.unidade = unidadeController.text;
                  unidade.sigla = siglaController.text;
                  unidade.active = isActive;
                  onSave(unidade);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
  void _createUnidade(BuildContext context) async {
    _showUnidadeDialog('Criar Unidade', UnidadeModel.newUnidade(), store.addUnidade, context);
  }

  void _updateUnidade(UnidadeModel unidade,BuildContext context) async {
    _showUnidadeDialog('Atualizar Unidade', unidade, store.updateUnidade,context);
  }

  @override
  Widget build(BuildContext context) {
    store.fetchUnidades();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unidades', style: TextStyle(color: Colors.blueGrey, fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [ ElevatedButton(
                    child: const Icon(Icons.add),
                    onPressed: () => {_createUnidade(context)},
                  ), ],
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, child) {
          return ListView.builder(
            itemCount: store.unidades.length,
            itemBuilder: (context, index) {
              final unidade = store.unidades[index];
              return Column(
                children: [
                  Card(
                    color: unidade.active ? Colors.orange[600] : Colors.red[900],
                    child: ListTile(
                      leading: Checkbox(
                      value: unidade.active,
                      onChanged: (bool? value) {
                          unidade.active = value!;
                          store.updateUnidade(unidade);
                        },
                      ),
                      title: Text(unidade.unidade, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(unidade.sigla, style: const TextStyle(color: Colors.white)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              _updateUnidade(unidade,context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              store.deleteUnidade(unidade);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _updateUnidade(unidade,context); // Chama a função de atualização
                      },
                    ),
                  ),
                ],
                
              );
              
            },
          );
        }     
      ),
    );
  }
}