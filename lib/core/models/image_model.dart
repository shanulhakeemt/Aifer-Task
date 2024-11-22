// ignore_for_file: public_member_api_docs, sort_constructors_first

class ImageModel {
  final String id;
  final UrlTypeModel urls;
  ImageModel({
    required this.id,
    required this.urls,
  });

  ImageModel copyWith({
    String? id,
    UrlTypeModel? urls,
  }) {
    return ImageModel(
      id: id ?? this.id,
      urls: urls ?? this.urls,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'urls': urls,
    };
  }

  factory ImageModel.fromMap(Map<dynamic, dynamic> map) {
    return ImageModel(
        id: map['id'] ?? '', urls: UrlTypeModel.fromMap(map['urls']));
  }
}

class UrlTypeModel {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  // ignore: non_constant_identifier_names
  final String small_s3;
  UrlTypeModel({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    // ignore: non_constant_identifier_names
    required this.small_s3,
  });

  UrlTypeModel copyWith({
    String? raw,
    String? full,
    String? regular,
    String? small,
    String? thumb,
    // ignore: non_constant_identifier_names
    String? small_s3,
  }) {
    return UrlTypeModel(
      raw: raw ?? this.raw,
      full: full ?? this.full,
      regular: regular ?? this.regular,
      small: small ?? this.small,
      thumb: thumb ?? this.thumb,
      small_s3: small_s3 ?? this.small_s3,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'raw': raw,
      'full': full,
      'regular': regular,
      'small': small,
      'thumb': thumb,
      'small_s3': small_s3,
    };
  }

  factory UrlTypeModel.fromMap(Map<dynamic, dynamic> map) {
    return UrlTypeModel(
      raw: map['raw'] ?? '',
      full: map['full'] ?? '',
      regular: map['regular'] ?? '',
      small: map['small'] ?? '',
      thumb: map['thumb'] ?? '',
      small_s3: map['small_s3'] ?? '',
    );
  }
}
