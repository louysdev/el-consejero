import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yes_no/domain/entities/message.dart';
import 'package:yes_no/presentation/providers/chat_provider.dart';
import 'package:yes_no/presentation/widgets/chat/bot_message_bubble.dart';
import 'package:yes_no/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Scaffold(
      backgroundColor: Color(0xff031829),
      // Barra estilizada con imagen
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(14))),
        leading: const Padding(
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://th.bing.com/th/id/OIG2.7gVbHyBo5MJHeaK.KKeH?pid=ImgGn"),
            )),
        actions: [
          IconButton(
              onPressed: () {
                chatProvider.deleteAllMessage();
              },
              icon: Icon(Icons.refresh_rounded))
        ],
        title: Text(
          "El consejero",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
        ),
      ),
      // Widget que contiene todo el estilo de la parte principal de la pantalla
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Crear instancia del chat provider. Ayuda a estar pendiente de los cambios de la clase
    final chatProvider = context.watch<ChatProvider>();
    // Recubre todo el area de la pantalla tomando en cuenta zonas donde hay elementos del movil.
    return SafeArea(
      child: Column(
        children: [
          // Expande todo su contenido en todo el tamaño que le permita
          Expanded(
              child: Container(
            // Lista de elementos optimizada para no cargar mas de la cuenta.
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length,
                // Aqui se van a renderizar tantos elementos como diga el contador
                itemBuilder: (context, index) {
                  final message = chatProvider.messageList[index];

                  return (message.fromWho == FromWho.me
                      ? MyMessageBubble(
                          message: message,
                        )
                      : BotMessageBubble(
                          message: message,
                        ));
                },
              ),
            ),
          )),
          MessageFieldBox(
            onValue: (value) => chatProvider.sendMessage(value),
          )
        ],
      ),
    );
  }
}
