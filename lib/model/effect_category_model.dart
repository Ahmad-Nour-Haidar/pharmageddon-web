class EffectCategoryModel {
  int? id;
  String? arabicName;
  String? englishName;
  String? imageName;
  bool? active;

  EffectCategoryModel(
      {this.id,
      this.arabicName,
      this.englishName,
      this.imageName,
      this.active});

  EffectCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
    imageName = json['image_name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arabic_name'] = arabicName;
    data['english_name'] = englishName;
    data['image_name'] = imageName;
    data['active'] = active;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EffectCategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          arabicName == other.arabicName &&
          englishName == other.englishName &&
          imageName == other.imageName &&
          active == other.active;

  @override
  int get hashCode =>
      id.hashCode ^
      arabicName.hashCode ^
      englishName.hashCode ^
      imageName.hashCode ^
      active.hashCode;
}
