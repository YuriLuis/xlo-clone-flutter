import 'package:intl/intl.dart';

extension StringExtension on String{

  bool isValidEmail() {
    bool result = false;
    if(this.contains('@') && this.contains(".com")){
      result = true;
    }
    return result;
  }

  bool isValidPassword() {
    bool result = false;
    if(this.length >= 6 && this.isNotEmpty){
      result = true;
    }
    return result;
  }
}

extension NumberExtension on num {

  String formattedMoney(){
    return NumberFormat('R\$###,##0.00', 'pt-BR').format(this);
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate(){
    return DateFormat('dd/MM/yyyy HH:mm', 'pt-BR').format(this);
  }
}