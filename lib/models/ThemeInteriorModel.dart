import 'dart:convert';

List<ThemeInteriorModel> themeInteriorModelFromJson(String str) => List<ThemeInteriorModel>.from(json.decode(str).map((x) => ThemeInteriorModel.fromJson(x)));

String themeInteriorModelToJson(List<ThemeInteriorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ThemeInteriorModel {
    String? imageUrl;
    String? themeName;

    ThemeInteriorModel({
        this.imageUrl,
        this.themeName,
    });

    factory ThemeInteriorModel.fromJson(Map<String, dynamic> json) => ThemeInteriorModel(
        imageUrl: json["image_url"],
        themeName: json["theme_name"],
    );

    Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "theme_name": themeName,
    };
}