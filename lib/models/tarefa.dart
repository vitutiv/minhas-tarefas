class Tarefa {
  final String id;
  String titulo;
  String descricao;
  bool completa;
  Tarefa({
    required this.id,
    required this.titulo,
    required this.descricao,
    this.completa = false,
  });

  // Converter Tarefa em um Map compatível com JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'completa': completa,
    };
  }

  // Reconstruir tarefa a partir do Map.
  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      completa: json['completa'],
    );
  }
}
