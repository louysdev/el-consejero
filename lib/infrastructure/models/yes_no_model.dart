import 'package:yes_no/domain/entities/message.dart';

// Modelo para la API de Yes or No

class YesNoModel {
  final String answer;
  final bool forced;
  final String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
      };

  // Mapper del modelo
  Message toMessageEntity() => Message(
      text: answer == "yes" ? "Si" : "No",
      fromWho: FromWho.bot,
      imageUrl: image);
}
