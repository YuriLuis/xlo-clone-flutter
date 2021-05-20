import 'cidade.dart';
import 'estado.dart';

class Endereco{

  Endereco({this.estado, this.cidade, this.cep, this.bairro});

  Estado estado;
  Cidade cidade;
  String cep;
  String bairro;

  @override
  String toString() {
    return 'Endereco{estado: $estado, cidade: $cidade, cep: $cep, bairro: $bairro}';
  }
}