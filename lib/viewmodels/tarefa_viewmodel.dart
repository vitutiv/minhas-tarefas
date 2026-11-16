import 'package:material_ui/material_ui.dart';
import 'package:minhas_tarefas/repositories/tarefa_repository.dart';
import 'package:uuid/uuid.dart';

import '../models/tarefa.dart';

class TarefaViewModel extends ChangeNotifier {
  final TarefaRepository _repository;

  TarefaViewModel(this._repository);

  List<Tarefa> get tarefas => _repository.tarefas;

  int get tarefasCompletas => tarefas.where((tarefa) => tarefa.completa).length;

  int get tarefasPendentes => tarefas.where((task) => !task.completa).length;

  void adicionarTarefa(String titulo, String descricao) {
    if (titulo.trim().isEmpty) return;
    _repository.adicionarTarefa(
      Tarefa(id: Uuid().v4(), titulo: titulo, descricao: descricao),
    );
    notifyListeners();
  }

  void definirEstadoDaTarefa(String idTarefa, bool novoEstado) {
    final tarefa = tarefas.firstWhere((t) => t.id == idTarefa);
    tarefa.completa = novoEstado;
    _repository.atualizarTarefa(tarefa);
    notifyListeners();
  }

  void apagarTarefa(String id) {
    _repository.apagarTarefa(id);
    notifyListeners();
  }
}
