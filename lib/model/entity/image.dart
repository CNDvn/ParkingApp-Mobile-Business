class Images {
  Images({
    this.id,
    this.url,
  });

  String? id;
  String? url;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}