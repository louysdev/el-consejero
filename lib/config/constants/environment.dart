import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String giphyKey = dotenv.env['API_KEY_GIPHY'] ?? "";
}