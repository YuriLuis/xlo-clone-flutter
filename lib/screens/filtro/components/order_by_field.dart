import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filtro/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  OrderByField(this.filterStore);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    Widget buildOptions(String title, OrderBy option) {
      return GestureDetector(
        onTap: () {
          filterStore.setOrderBy(option);
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              border: Border.all(
                  color: filterStore.orderBy == option
                      ? Colors.purple
                      : Colors.grey),
              borderRadius: BorderRadius.circular(25),
              color: filterStore.orderBy == option
                  ? Colors.purple
                  : Colors.transparent),
          child: Text(
            title,
            style: TextStyle(
                color: filterStore.orderBy == option
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Orderna por'),
        Observer(
          builder: (_) {
            return Row(
              children: [
                buildOptions('Data', OrderBy.DATE),
                SizedBox(
                  width: 12,
                ),
                buildOptions('Preço', OrderBy.PRICE)
              ],
            );
          },
        )
      ],
    );
  }
}
