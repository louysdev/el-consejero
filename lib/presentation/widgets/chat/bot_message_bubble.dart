import 'package:flutter/material.dart';
import 'package:yes_no/domain/entities/message.dart';

class BotMessageBubble extends StatelessWidget {
  final Message message;

  const BotMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final String messageText; 

    if(message.text == "Si") {
      messageText = "Si 🍻";
    } else if(message.text == "No") {
      messageText = "No 😞";
    } else {
      messageText = message.text;
    }

    // Forma de obtener los colores del colorSchemeSeed del tema principal de la aplicacion
    final colors = Theme.of(context).colorScheme;
    print("colores: ${colors}");

    return Column(
      // Ubicacion de la columna
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        Container(
          //Estilo del contenedor
          decoration: BoxDecoration(
              color: colors.onPrimary, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              messageText,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Imagen traida desde una API
        _ImageBubble(imageUrl: message.imageUrl!),
      ],
    );
  }
}

// Widget personalizado para mostrar el GIF
class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Manera de dar borders redondeados
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          width: size.width * 0.4,
          height: 250,
          fit: BoxFit.cover,
          // Mostrar algo cuando la imagen aun no esta cargada
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return Container(
              width: size.width * 0.4,
              height: 250,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.white,
              child: const Center(
                  child: Text("Estoy analizando tu peticion 🤔🍺")),
            );
          },
        ));
  }
}
