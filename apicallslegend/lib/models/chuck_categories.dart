class ChuckCategories {
  final List<String> categories;

  ChuckCategories({this.categories});

  factory ChuckCategories.fromJson(List<dynamic> json) {
    return ChuckCategories(
      categories: json != null ? new List<String>.from(json) : null,
    );
  }

  List<dynamic> toJson() {
    List<dynamic> data = new List<String>();
    if (this.categories != null) {
      data = this.categories;
    }
    return data;
  }
}
