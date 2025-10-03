import 'package:json_annotation/json_annotation.dart';
import 'package:tp1_flutter/singleton_dio.dart';
import 'package:dio/dio.dart';

part 'transfert.g.dart';

@JsonSerializable()
class RequeteInscription {
  String nom= "";
  String motDePasse = "";
  String confirmationMotDePasse = "";


  RequeteInscription();

  factory RequeteInscription.fromJson(Map<String, dynamic> json) =>
      _$RequeteInscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$RequeteInscriptionToJson(this);
}
@JsonSerializable()
class RequeteConnexion {
  String nom= "";
  String motDePasse = "";

  RequeteConnexion();

  factory RequeteConnexion.fromJson(Map<String, dynamic> json) =>
      _$RequeteConnexionFromJson(json);

  Map<String, dynamic> toJson() => _$RequeteConnexionToJson(this);
}

class ReponseConnexion {
  final String message;
  final String? username;
  String nomUtilisateur = "string";

  ReponseConnexion({required this.message, this.username});

  factory ReponseConnexion.fromJson(dynamic data) {
    if (data is Map<String, dynamic>) {
      return ReponseConnexion(
        message: data['message'] ?? '',
        username: data['username'],
      );
    } else if (data is String) {
      // Si le serveur renvoie une String brute (pas JSON)
      return ReponseConnexion(
        message: data,
        username: null,
      );
    } else {
      throw Exception("Format de réponse inconnu");
    }
  }
}

Future<ReponseConnexion> inscriptionAPI(RequeteInscription req) async {
  try {
    final response = await SingletonDio.getDio().post(
      'http://10.0.2.2:8080/id/inscription',
      data: req.toJson(),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    print("Status code: ${response.statusCode}");
    print("Réponse brute: ${response.data}");

    return ReponseConnexion.fromJson(response.data);
  } catch (e) {
    print("Erreur API : $e");

    if (e is DioError && e.response != null) {
      print("Erreur Dio : ${e.response?.data}");
    }

    rethrow;
  }
}
Future<ReponseConnexion> connexionAPI(RequeteConnexion req) async {
  try {
    final response = await SingletonDio.getDio().post(
      'http://10.0.2.2:8080/id/connexion',
      data: req.toJson(),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    print("Status code: ${response.statusCode}");
    print("Réponse brute: ${response.data}");

    return ReponseConnexion.fromJson(response.data);
  } catch (e) {
    print("Erreur API : $e");

    if (e is DioError && e.response != null) {
      print("Erreur Dio : ${e.response?.data}");
    }

    rethrow;
  }
}
Future<void> deconnexionAPI() async {
  try {
    final response = await SingletonDio.getDio().post(
      'http://10.0.2.2:8080/id/deconnexion',
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("Déconnexion réussie, status code : ${response.statusCode}");
  } catch (e) {
    print("Erreur lors de la déconnexion : $e");
  }
}

