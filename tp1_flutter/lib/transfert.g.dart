// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequeteInscription _$RequeteInscriptionFromJson(Map<String, dynamic> json) =>
    RequeteInscription()
      ..nom = json['nom'] as String
      ..motDePasse = json['motDePasse'] as String
      ..confirmationMotDePasse = json['confirmationMotDePasse'] as String;

Map<String, dynamic> _$RequeteInscriptionToJson(RequeteInscription instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'motDePasse': instance.motDePasse,
      'confirmationMotDePasse': instance.confirmationMotDePasse,
    };

RequeteConnexion _$RequeteConnexionFromJson(Map<String, dynamic> json) =>
    RequeteConnexion()
      ..nom = json['nom'] as String
      ..motDePasse = json['motDePasse'] as String;

Map<String, dynamic> _$RequeteConnexionToJson(RequeteConnexion instance) =>
    <String, dynamic>{'nom': instance.nom, 'motDePasse': instance.motDePasse};
