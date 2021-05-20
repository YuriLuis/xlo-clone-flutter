import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx/model/cidade.dart';
import 'package:xlo_mobx/model/estado.dart';

class IBGERepository {
  final String keyEstados = 'UF_LIST';

  Future<List<Estado>> getUfListFromApiOrCache() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(keyEstados)) {
      print('Pegou dados do SharedPreferences');
      final jsonEstados = json.decode(preferences.get(keyEstados));

      return jsonEstados
          .map<Estado>((jsonUF) => Estado.fromJson(jsonUF))
          .toList()
            ..sort((Estado a, Estado b) =>
                a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    }

    print('Não Pegou dados do SharedPreferences');

    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final responseListEstadosBrasil = await Dio().get<List>(endpoint);

      preferences.setString(
          keyEstados, json.encode(responseListEstadosBrasil.data));

      final listEstadosBrasil = responseListEstadosBrasil.data
          .map<Estado>((jsonUF) => Estado.fromJson(jsonUF))
          .toList()
            ..sort((Estado a, Estado b) =>
                a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));

      return listEstadosBrasil;
    } on DioError {
      return Future.error('Falha ao obter lista de Estados');
    }
  }

  Future<List<Cidade>> getCityListFromApiOrCache(Estado estado) async {
    final endpoint = 'https://servicodados.ibge.gov.br/api/v1/localidades/'
        'estados/${estado.id}/municipios';

    try {
      final responseListMunicipiosDeUmEstado = await Dio().get<List>(endpoint);
      final listaDeCidadesEmUmEstado = responseListMunicipiosDeUmEstado.data
          .map<Cidade>((jsonCidades) => Cidade.fromJson(jsonCidades))
          .toList()
            ..sort((Cidade a, Cidade b) =>
                a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));

      return listaDeCidadesEmUmEstado;
    } on DioError {
      return Future.error('Falha ao obter lista de Estados');
    }
  }
}
