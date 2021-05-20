import 'package:dio/dio.dart';
import 'package:xlo_mobx/model/uf.dart';

class IBGERepository {
  Future<List<UF>> getUfListFromApi() async {
    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final responseListEstadosBrasil = await Dio().get<List>(endpoint);

      final listEstadosBrasil = responseListEstadosBrasil.data
          .map<UF>((jsonUF) => UF.fromJson(jsonUF)).toList()
      ..sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));

      return listEstadosBrasil;
    } on DioError {
      return Future.error('Falha ao obter lista de Estados');
    }
  }

  getCityListFromApi() {}
}
