import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Inicia o binding do flutter para não ter erro
  await initializeParse();
  setupLocators();
  runApp(MyApp());
}

void setupLocators(){
  GetIt.I.registerSingleton(PageStore());
}

Future<void> initializeParse() async {
  await Parse().initialize(
    'b9VioR9kENCC7uLrMa9Ee7n5PBTLMR472Z3losEL',
    'https://parseapi.back4app.com/',
    clientKey: 'eiTp7vjTyj3GwkdB64jSHKyt6cCZVVbbDpbvmhFk',
    autoSendSessionId: true,
    debug: true,
  );

  final category = ParseObject('Categories')..objectId = 'MjBk8QpOco';
  final response = await category.delete();
  print(response.success);
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.purple,
          appBarTheme: AppBarTheme(elevation: 0),
          cursorColor: Colors.orange),
      home: BaseScreen(),
    );
  }
}
