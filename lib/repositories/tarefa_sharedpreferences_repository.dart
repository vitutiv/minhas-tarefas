import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];
  static const String _storageKey = 'minhas_tarefas';
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  List<Tarefa> get tarefas {
    return List.unmodifiable(_tarefas);
  }

  // Retrieve tasks from local storage.
  Future<List<Tarefa>> obterTarefas() async {
    final String? data = await _preferences.getString(_storageKey);
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => Tarefa.fromJson(item)).toList();
  }

  // Save tasks to local storage.
  Future<void> salvarTarefas(List<Tarefa> tasks) async {
    final String data = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await _preferences.setString(_storageKey, data);
  }

  void adicionarTarefa(Tarefa tarefa) {
    _tarefas.add(tarefa);
  }

  void apagarTarefa(String idTarefa) {
    _tarefas.removeWhere((tarefa) => tarefa.id == idTarefa);
  }

  void atualizarTarefa(Tarefa tarefaAtualizada) {
    final indice = _tarefas.indexWhere(
      (tarefa) => tarefa.id == tarefaAtualizada.id,
    );
    if (indice != -1) {
      _tarefas[indice] = tarefaAtualizada;
    }
  }
}
