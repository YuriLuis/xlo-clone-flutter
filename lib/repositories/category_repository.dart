import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/model/category.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class CategoryRepository {

  Future<List<Category>>getListCategory() async {
    /// query já trás todas as categorias cadastradas no parse serve
    /// em ordem alfábetica.
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryDescription);

    final response = await queryBuilder.query();
    if (response.success) {
      return response.results
        ..map((parseObject) => Category.fromParse(parseObject)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}
