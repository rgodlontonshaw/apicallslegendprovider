class ChuckResponse {
  final List<String> categories;
  final String createdAt;
  final String iconUrl;
  final String id;
  final String updatedAt;
  final String url;
  final String value;

  ChuckResponse(
      {this.categories,
      this.createdAt,
      this.iconUrl,
      this.id,
      this.updatedAt,
      this.url,
      this.value});

  factory ChuckResponse.fromJson(Map<String, dynamic> json) {
    return ChuckResponse(
      categories: json['categories'] != null
          ? new List<String>.from(json['categories'])
          : null,
      createdAt: json['created_at'] ?? '',
      iconUrl: json['icon_url'] ?? "",
      id: json['id'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      url: json['url'] ?? "",
      value: json['value'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['icon_url'] = this.iconUrl;
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    data['value'] = this.value;
    if (this.categories != null) {
      data['categories'] = this.categories;
    }
    return data;
  }
}
