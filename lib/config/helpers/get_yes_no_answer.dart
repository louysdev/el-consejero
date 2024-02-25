import 'package:dio/dio.dart';
import 'package:yes_no/config/helpers/get_giphy_answer.dart';
import 'package:yes_no/domain/entities/message.dart';
import 'package:yes_no/infrastructure/models/yes_no_model.dart';

// Clase donde se manejara la peticion de YesNoAPI
class GetYesNoAnswer {
  // Instancia del paquete para manejar peticiones http
  final _dio = Dio();
  final GetGiphyAnswer getGiphyAnswer = GetGiphyAnswer();

  Future<Message> getAnswer() async {
    // Respuesta de la API
    final response = await _dio.get("https://yesno.wtf/api");
    final responseImageGiphy = await getGiphyAnswer.getAnswer();

    // Si la peticion lanza un "yes" usa el GIF de la otra API
    if (response.data["answer"] == "yes") {
      response.data["image"] = responseImageGiphy;
    }

    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    // Devuelve una entidad del mensaje
    return yesNoModel.toMessageEntity();
  }
}
