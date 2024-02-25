import 'dart:math';

import 'package:dio/dio.dart';
import 'package:yes_no/config/constants/environment.dart';
import 'package:yes_no/infrastructure/models/giphy_model.dart';

final apiKey = Environment.giphyKey;

// Clase donde se maneja la peticion a la API
class GetGiphyAnswer {
  // Instancia del paquete para manejar peticiones
  final _dio = Dio();
  final baseUrl = "https://api.giphy.com/v1/gifs/search";

  // Parametros para la peticion
  final Map<String, dynamic> queryParams = {
    "api_key": apiKey,
    "q": "whiskey",
    "limit": 1,
    "offset": 0,
    "rating": "r",
    "lang": "en",
    "bundle": "messaging_non_clips"
  };

  // Obtener la respuesta
  Future<String> getAnswer() async {
    // Cada que se haga una peticion se cambian la posicion para otro GIF
    queryParams["offset"] = Random().nextInt(50);

    final response = await _dio.get(baseUrl, queryParameters: queryParams);
    final giphyModel = GiphyModel.fromJson(response.data);

    // Obtener la imagen de toda la data
    final imageUrl = giphyModel.getFixedHeightImages();

    // Retorna una imagen
    return imageUrl[0];
  }
}
