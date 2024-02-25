import 'package:flutter/material.dart';
import 'package:yes_no/domain/entities/message.dart';

class MyMessageBubble extends StatelessWidget {
  // Parametro que se recibira
  final Message message;

  const MyMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Forma de obtener los colores del colorSchemeSeed del tema principal de la aplicacion
    final colors = Theme.of(context).colorScheme;
    print("colores: ${colors}");

    return Column(
      // Ubicacion de la columna
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 10),
        Container(
          //Estilo del contenedor
          decoration: BoxDecoration(
              color: colors.onSecondary,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              message.text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
