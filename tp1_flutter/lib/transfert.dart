import 'package:tp1_flutter/singleton_dio.dart';
import 'package:dio/dio.dart';

class RequeteInscription {
  final String username;
  final String password;

  RequeteInscription({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}
class RequeteConnexion {
  final String username;
  final String password;

  RequeteConnexion({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}

class ReponseConnexion {
  final String message;
  final String? username;

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
      'http://10.0.2.2:8080/api/id/signup',
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
      'http://10.0.2.2:8080/api/id/signin',
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
      'http://10.0.2.2:8080/api/id/signout',
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("Déconnexion réussie, status code : ${response.statusCode}");
  } catch (e) {
    print("Erreur lors de la déconnexion : $e");
  }
}
