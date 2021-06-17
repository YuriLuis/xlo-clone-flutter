import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'components/order_by_field.dart';
import 'components/price_range_field.dart';
import 'components/vendor_type_field.dart';

class FiltroScreen extends StatelessWidget {
  final FilterStore filterStore = GetIt.I<HomeStore>().clonedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Busca'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderByField(filterStore),
                  PriceRangeField(filterStore),
                  VendorTypeField(filterStore),
                  Observer(builder: (_) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      height: 50,
                      child: RaisedButton(
                        elevation: 0,
                        disabledColor: Colors.orange.withAlpha(120),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        textColor: Colors.white,
                        color: Colors.orange,
                        onPressed: filterStore.isFormValid
                            ?(){
                          filterStore.save();
                          Navigator.of(context).pop();
                        }
                            : null ,
                        child: Text(
                          'FILTRAR',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
