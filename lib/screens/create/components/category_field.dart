import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CategoryField extends StatelessWidget {
  CategoryField({this.createStore});

  final CreateStore createStore;

  final textStyleFont18 = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18,
  );

  final textStyleFont14 = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            ListTile(
              title: createStore.category == null
                  ? Text(
                      'Categoria *',
                      style: textStyleFont18,
                    )
                  : Text(
                      'Categoria *',
                      style: textStyleFont14,
                    ),
              subtitle: createStore.category == null
                  ? null
                  : Text(
                      '${createStore.category.description}',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final category = await showDialog(
                    context: context,
                    builder: (_) => CategoryScreen(
                          showAll: false,
                          selected: createStore.category,
                        ));
                if (category != null) {
                  createStore.setCategory(category);
                }
              },
            ),
            if (createStore.categoryError != null)
              Container(
                padding: EdgeInsets.fromLTRB(16, 6, 8, 0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.red))),
                child: Text(
                  createStore.categoryError,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey[500]))
                ),
              )
          ],
        );
      },
    );
  }
}
