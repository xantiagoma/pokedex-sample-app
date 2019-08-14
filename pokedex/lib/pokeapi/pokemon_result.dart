import 'dart:convert';

class ResultElement {
    String name;
    String url;

    ResultElement({
        this.name,
        this.url,
    });

    factory ResultElement.fromJson(String str) => ResultElement.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ResultElement.fromMap(Map<String, dynamic> json) => new ResultElement(
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "url": url == null ? null : url,
    };
}
