import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/filtro/components/section_title.dart';

class OrderByField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buildOptions(String title) {
      return Container(
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.purple),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Orderna por'),
        Row(
          children: [
            buildOptions('Data'),
            SizedBox(
              width: 12,
            ),
            buildOptions('Preço')
          ],
        ),
      ],
    );
  }
}
