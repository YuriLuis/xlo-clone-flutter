import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CepField extends StatelessWidget {
  CepField(this.createStore) : cepStore = createStore.cepStore;

  final CreateStore createStore;
  final CepStore cepStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(
            builder: (_) {
              return TextFormField(
                onChanged: cepStore.setCep,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                decoration: InputDecoration(
                    errorText: createStore.enderecoError,
                    labelText: 'CEP *',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                        fontSize: 18),
                    contentPadding: EdgeInsets.fromLTRB(16, 10, 12, 10)),
              );
            },
        ),
        Observer(
          // ignore: missing_return
          builder: (_) {
            if (cepStore.endereco == null &&
                cepStore.error == null &&
                !cepStore.loading) {
              return Container();
            } else if (cepStore.endereco == null && cepStore.error == null) {
              return LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purple),
                backgroundColor: Colors.transparent,
              );
            } else if (cepStore.error != null) {
              return Container(
                color: Colors.red.withAlpha(100),
                height: 50,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  cepStore.error,
                  style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                ),
              );
            } else {
              final endereco = cepStore.endereco;
              return Container(
                alignment: Alignment.center,
                color: Colors.purple.withAlpha(150),
                height: 50,
                padding: EdgeInsets.all(8),
                child: Text(
                  'Localização: ${endereco.bairro} , ${endereco.cidade.nome} - '
                      '${endereco.estado.sigla}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
