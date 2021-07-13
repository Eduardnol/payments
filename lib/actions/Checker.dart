/*
Vamos a comprobar y depurar la información introducida por el usuario
 */

bool checkDate(DateTime dateTime) {
  if (dateTime.day == 29 || dateTime.day == 30 || dateTime.day == 31) {
    return false;
  }
  return true;
}

//Transformamos los decimales para que nuestra aplicación los acepte
double transformValue(String str) {
  str = str.replaceAll(RegExp(','), '.');

  var number = double.parse(str).abs();

  number = double.parse(number.toStringAsFixed(2));

  print("Tenemos como resultado:  $number");
  if (number == null) number = 0;
  return number;
}
