// Enumeracion controlada
enum FromWho { me, bot }

// Molde de como debe de lucir la informacion relevante que necesito para que mi aplicacion funcione.
class Message {
  final String text;
  final String? imageUrl;
  final FromWho fromWho;

  Message({required this.text, this.imageUrl, required this.fromWho});
}
