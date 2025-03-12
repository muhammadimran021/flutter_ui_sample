import 'dart:convert';

FileUploadResponseModel fileUploadResponseModelFromJson(String str) => FileUploadResponseModel.fromJson(json.decode(str));

String fileUploadResponseModelToJson(FileUploadResponseModel data) => json.encode(data.toJson());

class FileUploadResponseModel {
    String? originalname;
    String? filename;
    String? location;

    FileUploadResponseModel({
        this.originalname,
        this.filename,
        this.location,
    });

    factory FileUploadResponseModel.fromJson(Map<String, dynamic> json) => FileUploadResponseModel(
        originalname: json["originalname"],
        filename: json["filename"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "originalname": originalname,
        "filename": filename,
        "location": location,
    };
}
