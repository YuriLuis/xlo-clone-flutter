import 'package:dio/dio.dart';
import 'package:xlo_mobx/model/cidade.dart';
import 'package:xlo_mobx/model/endereco.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';

import '../model/cidade.dart';
import '../model/endereco.dart';
import 'ibge_repository.dart';

class CepRepository{

  Future<Endereco> getEnderecoFromApi(String cep) async {
    if(isCepInvalido(cep)){
      return Future.error('Cep inválido!');
    }else {
      final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');
      if(clearCep.length != 8){
        Future.error(' length != 8 trueCep inválido!');
      }else {
        final endpoint = 'https://viacep.com.br/ws/$clearCep/json/';

        try{
          final response = await Dio().get<Map>(endpoint);
          if(response.data.containsKey('erro') && response.data['erro']){
            return Future.error('Cep não existe');
          }else {
            final ufList = await IBGERepository().getUfListFromApiOrCache();

            return Endereco(
              cep: response.data['cep'],
              bairro: response.data['bairro'],
              cidade: Cidade(nome: response.data['localidade']),
              estado: ufList.firstWhere((uf) => uf.sigla == response.data['uf'])
            );
          }
        } catch(e){
          return Future.error('Falha ao buscar Cep');
        }
      }
    }
  }
  
  bool isCepInvalido(String cep){
    return cep.isEmpty || cep == null && cep.length != 8;
  }
}