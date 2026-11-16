import 'package:material_ui/material_ui.dart';
import 'package:minhas_tarefas/viewmodels/tarefa_viewmodel.dart';

class NovaTarefaPage extends StatelessWidget {
  new({super.key, required this.viewModel});

  final TarefaViewModel viewModel;
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova tarefa'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (tituloController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor preencha o título!')),
                );
              } else {
                viewModel.adicionarTarefa(
                  tituloController.text,
                  descricaoController.text,
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: InputDecoration(hint: Text('Título')),
            ),
            TextField(
              controller: descricaoController,
              maxLines: 5,
              decoration: InputDecoration(hint: Text('Descrição')),
            ),
          ],
        ),
      ),
    );
  }
}
