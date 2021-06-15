import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filtro/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  VendorTypeField(this.filterStore);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle('Tipo de anunciante'),
        Observer(
          builder: (_) {
            return Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 4,
              children: [
                _particularButton(),
                SizedBox(
                  width: 12,
                ),
                _profissionalButton(),
              ],
            );
          },
        ),
        _widgetTextErroTypeVendor()
      ],
    );
  }

  Widget _particularButton() {
    return GestureDetector(
      onTap: () {
        _clickButtonParticular();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        height: 50,
        width: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: filterStore.isTypeParticular
                ? Colors.purple
                : Colors.transparent,
            border: Border.all(
                color: filterStore.isTypeParticular
                    ? Colors.purple
                    : Colors.grey[700])),
        child: Text(
          'Particular',
          style: TextStyle(
              color:
              filterStore.isTypeParticular ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _profissionalButton() {
    return GestureDetector(
      onTap: () {
        _clickButtonProfissional();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        height: 50,
        width: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: filterStore.isTypeProfissional
                ? Colors.purple
                : Colors.transparent,
            border: Border.all(
                color: filterStore.isTypeProfissional
                    ? Colors.purple
                    : Colors.grey[700])),
        child: Text(
          'Profissional',
          style: TextStyle(
              color: filterStore.isTypeProfissional
                  ? Colors.white
                  : Colors.black),
        ),
      ),
    );
  }

  Widget _widgetTextErroTypeVendor(){
    return Observer(
      builder: (_) {
        if(filterStore.isTypeVendorError != null){
          return Container(
            padding: EdgeInsets.only(top: 8),
            child: Text(filterStore.isTypeVendorError,
              style: TextStyle(color: Colors.red, fontSize: 14),),
          );
        }else {
          return Container();
        }
      },
    );
  }

  void _clickButtonProfissional() {
    filterStore.setProfissionalVendor();
    if (filterStore.isProfissionalVendor) {
      print('Profissional Vendedor = ${filterStore.isTypeProfissional}');
    } else {
      print('Profissional Vendedor = ${filterStore.isTypeProfissional}');
    }
  }

  void _clickButtonParticular() {
    filterStore.setParticularVendor();
    if (filterStore.isParticularVendor) {
      print('Particular Vendedor = ${filterStore.isTypeParticular}');
    } else {
      print('Particular Vendedor = ${filterStore.isTypeParticular}');
    }
  }
}
