class Estado{

  Estado({this.id, this.sigla, this.nome});

  factory Estado.fromJson(Map<String, dynamic> json) => Estado(
    id: json['id'],
    sigla: json['sigla'],
    nome: json['nome']
  );

  int id;
  String sigla;
  String nome;

  @override
  String toString() {
    return 'Estado{id: $id, sigla: $sigla, nome: $nome}';
  }
}