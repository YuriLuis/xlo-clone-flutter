import 'package:flutter/material.dart';
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
      ],
    );
  }
}
