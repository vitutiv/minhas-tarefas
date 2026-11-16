import '../models/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas {
    return List.unmodifiable(_tarefas);
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
