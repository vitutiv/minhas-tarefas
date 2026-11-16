import 'package:material_ui/material_ui.dart';

import '../repositories/tarefa_repository.dart';
import '../viewmodels/tarefa_viewmodel.dart';
import 'nova_tarefa_page.dart';

class TarefasHomePage extends StatefulWidget {
  const TarefasHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TarefasHomePage> createState() => _TarefasHomePageState();
}

class _TarefasHomePageState extends State<TarefasHomePage> {
  late final TarefaViewModel viewModel;
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = TarefaViewModel(TarefaRepository());
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) => viewModel.tarefas.isEmpty
              ? Text('Nenhuma tarefa. Por favor, clique no "+" para adicionar.')
              : ListView.separated(
                  itemBuilder: (context, index) {
                    var tarefa = viewModel.tarefas[index];
                    return Dismissible(
                      key: ValueKey(tarefa),
                      onDismissed: (direction) {
                        viewModel.apagarTarefa(tarefa.id);
                      },
                      child: ListTile(
                        leading: Checkbox(
                          value: tarefa.completa,
                          onChanged: (novoEstado) =>
                              viewModel.definirEstadoDaTarefa(
                                tarefa.id,
                                novoEstado ?? false,
                              ),
                        ),
                        title: Text(tarefa.titulo),
                        subtitle: Text(tarefa.descricao),
                        trailing: IconButton(
                          onPressed: () {
                            viewModel.apagarTarefa(tarefa.id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: viewModel.tarefas.length,
                  shrinkWrap: true,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarTelaDeNovaTarefa,
        tooltip: 'Criar',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarTelaDeNovaTarefa() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovaTarefaPage(viewModel: viewModel),
      ),
    );
  }
}
