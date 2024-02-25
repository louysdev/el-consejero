import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no/presentation/providers/chat_provider.dart';

// Campo de texto personalizado
class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
 
    final chatProvider = context.watch<ChatProvider>();

    // Controlador para manejar los datos de entrada
    final textController = TextEditingController();
    // Controlador para manejar el comportamiento
    final focusNode = FocusNode();

    // final colors = Theme.of(context).colorScheme;

    // Estilo separada ya que se requiere el mismo
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    // Estilos de la caja de texto
    final inputDecoration = InputDecoration(
        hintText: 'Termina con un "?" para preguntarme',
        fillColor: Colors.white,
        filled: true,
        // Estilos del border, tanto cuando esta normal y escribiendo
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        suffixIcon: IconButton(
          icon: Icon(Icons.send_rounded),
          onPressed: () {
            // Obtener el valor de la caja de texto del controlador
            final textValue = textController.value.text;
            onValue(textValue);
            // No se debe de manejar estos controles aqui, ya que la logica esta en provider
            // if (textValue != "") {
            //   onValue(textValue);
            // }
            // Limpiar la caja
            textController.clear();
          },
        ));

    return TextFormField(
      // keyboardType: TextInputType.number,
      // Controladores
      focusNode: focusNode,
      controller: textController,
      // Estilo
      decoration: inputDecoration,
      // Determinar la accion al tocar fuera
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      onTap: () {
        chatProvider.onTap();
      },
      // Cuando se manda un mensaje por el teclado
      onFieldSubmitted: (value) {
        onValue(value);
        textController.clear();
        // Mantener el foco aun despues de haber mandado el mensaje
        focusNode.requestFocus();
      },
    );
  }
}
