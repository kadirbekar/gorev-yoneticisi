import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({this.result, this.message, this.islemKodu});

   bool result;
   String message;
   int islemKodu;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        result: json["result"],
        message: json["message"],
        islemKodu: json["islemKodu"],
      );

  Map<String, dynamic> toJson() =>
      {"result": result, "message": message, "islemKodu": islemKodu};
}