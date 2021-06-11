import 'package:mobx/mobx.dart';

part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  int minPrice;

  @observable
  int maxPrice;

  @action
  void setMinPrice(int value) => minPrice = value;

  @action
  void setMaxPrice(int value) => maxPrice = value;

  @computed
  String get priceError =>
      maxPrice != null && minPrice != null && maxPrice < minPrice
          ? 'Faixa de preço inválida'
          : null;

  @observable
  bool isParticularVendor = true;

  @observable
  bool isProfissionalVendor = false;

  @action
  void setParticularVendor() => isParticularVendor = !isParticularVendor;

  void setProfissionalVendor() => isProfissionalVendor = !isProfissionalVendor;

  @computed
  bool get isTypeParticular => isParticularVendor;

  bool get isTypeProfissional => isProfissionalVendor;

  bool get isTypeVendorValidor => isParticularVendor || isProfissionalVendor;

  String get isTypeVenderError =>
      isTypeVendorValidor ? null : 'Informe o tipo do anunciante';
}
