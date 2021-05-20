class UF{

  UF({this.id, this.sigla, this.nome});

  factory UF.fromJson(Map<String, dynamic> json) => UF(
    id: json['id'],
    sigla: json['sigla'],
    nome: json['nome']
  );

  int id;
  String sigla;
  String nome;

  @override
  String toString() {
    return 'UF{id: $id, sigla: $sigla, nome: $nome}';
  }
}