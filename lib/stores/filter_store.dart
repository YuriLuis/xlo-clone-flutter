import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/stores/home_store.dart';

part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore(
      {this.orderBy = OrderBy.DATE,
      this.minPrice,
      this.maxPrice,
      this.isProfissionalVendor = false,
      this.isParticularVendor = true});

  @observable
  OrderBy orderBy;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  int minPrice;

  @observable
  int maxPrice;

  @observable
  int vendorType = 1;

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
  bool isParticularVendor = false;

  @observable
  bool isProfissionalVendor = false;

  @action
  void setParticularVendor() => isParticularVendor = !isParticularVendor;

  void setProfissionalVendor() => isProfissionalVendor = !isProfissionalVendor;

  @computed
  bool get isTypeParticular => isParticularVendor;

  bool get isTypeProfissional => isProfissionalVendor;

  bool get isTypeVendorValidor => isParticularVendor || isProfissionalVendor;

  String get isTypeVendorError =>
      isTypeVendorValidor ? null : 'Informe o tipo do anunciante';

  bool get isFormValid =>
      priceError == null && isTypeVendorError == null && isTypeVendorValidor;

  void save() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
        orderBy: orderBy,
        minPrice: minPrice,
        maxPrice: maxPrice,
        isParticularVendor: isParticularVendor,
        isProfissionalVendor: isProfissionalVendor);
  }
}
