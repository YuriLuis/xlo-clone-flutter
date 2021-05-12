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