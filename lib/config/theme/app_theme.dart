import 'package:flutter/material.dart';

// Variables que usara la clase mas adelante, pero como necesitan que las pasemos por fuera, se declaran fuera de ella
const Color _favoriteColor = Color(0xffdd8432);

const List<Color> _colorList = [
  _favoriteColor,
  Color(0xff011828),
  Color(0xffd6eeee),
];

class AppTheme {
  final int selectedColor;

  // Contructor de la clase que recibe el (selectedColor), en caso de que en tiempo de desarrollo, se ingresa un valor incorrecto, la pantalla de error le mostrara un mensaje personalizado con el error controlado
  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0, "El (selectedColor) debe ser >= 0"),
        assert(selectedColor <= _colorList.length,
            "El (selectedColor) debe ser <= ${_colorList.length}");

  // Metodo de clase que devuelve el tema principal de la aplicacion
  ThemeData theme() {
    return ThemeData(
        colorSchemeSeed: _colorList[selectedColor],
        // brightness: Brightness.dark
        );
  }
}
