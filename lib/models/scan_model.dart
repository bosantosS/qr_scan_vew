// To parse this JSON data, do
//  https://app.quicktype.io/
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';
import 'package:meta/meta.dart';//Libreria para el required

//Toma el JSON String y crea una instancia del modelo
ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  //@required los hace obligatorios
  ScanModel({this.id,@required this.valor, this.tipo,}) {
    //Puede ser Switch y Enum
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  int id;
  String valor;
  String tipo;

  //Crea instancias, a partir del mapa pasado por parametro
  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        valor: json["valor"],
        tipo: json["tipo"],
      );

  //Regresa un Map, {key:value}, desde una instancia.
  Map<String, dynamic> toJson() => {
        "id": id,
        "valor": valor,
        "tipo": tipo,
      };
}
