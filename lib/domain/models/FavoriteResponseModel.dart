// To parse this JSON data, do
//
//     final favoriteResponseModel = favoriteResponseModelFromJson(jsonString);

import 'dart:convert';

FavoriteResponseModel favoriteResponseModelFromJson(String str) => FavoriteResponseModel.fromJson(json.decode(str));

String favoriteResponseModelToJson(FavoriteResponseModel data) => json.encode(data.toJson());

class FavoriteResponseModel {
    bool success;
    int statusCode;
    String statusMessage;

    FavoriteResponseModel({
        required this.success,
        required this.statusCode,
        required this.statusMessage,
    });

    factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) => FavoriteResponseModel(
        success: json["success"],
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "status_message": statusMessage,
    };
}
