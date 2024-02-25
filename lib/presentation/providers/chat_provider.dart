import 'package:flutter/material.dart';
import 'package:yes_no/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no/domain/entities/message.dart';

final Message defaultMessage = Message(
    text: "Confia en mi y goza 😏",
    fromWho: FromWho.bot,
    imageUrl:
        "https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExdDBjdmZyY2pvMGwzYjVnZmNyZHE5aHN3cnR0emlxajRocmx1bThxbCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/wrBURfbZmqqXu/giphy.gif");

// El gestor de estado de la aplicacion
class ChatProvider extends ChangeNotifier {
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();
  // Controlador del scroll del ListView
  final ScrollController chatScrollController = ScrollController();

  // Lista de los mensajes del chat
  List<Message> messageList = [
    defaultMessage,
    // Message(text: "Klk", fromWho: FromWho.me),
    // Message(text: "Hoy se bebe?", fromWho: FromWho.me)
  ];

  // Funcion que se encargara de mandar el mensaje
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if (text.endsWith("?")) {
      botReply();
    }

    notifyListeners();
    moveScrollToBottom();
  }

  // Funcion para mover el scroll al final cuando se manda un mensaje
  Future<void> moveScrollToBottom() async {
    // Hacer esperar unos segundos para que el mensaje llegue como se espera
    await Future.delayed(const Duration(milliseconds: 100));

    // Mover y animar el scroll
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

    // Funcion para mover el scroll al final cuando se manda un mensaje
  Future<void> onTap() async {
    // Hacer esperar unos segundos para que el mensaje llegue como se espera
    await Future.delayed(const Duration(milliseconds: 100));

    // Mover y animar el scroll
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  // Funcion que obtendra el mensaje de ella cuando se detecte un "?"
  Future<void> botReply() async {
    final botMessage = await getYesNoAnswer.getAnswer();
    messageList.add(botMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  // Borrar todos los mensajes
  void deleteAllMessage() {
    messageList = [defaultMessage];
    notifyListeners();
    moveScrollToBottom();
  }
}
