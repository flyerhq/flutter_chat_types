// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialImage _$PartialImageFromJson(Map<String, dynamic> json) => PartialImage(
      height: (json['height'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String,
      size: json['size'] as num,
      uri: json['uri'] as String,
      width: (json['width'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PartialImageToJson(PartialImage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('height', instance.height);
  writeNotNull('metadata', instance.metadata);
  val['name'] = instance.name;
  val['size'] = instance.size;
  val['uri'] = instance.uri;
  writeNotNull('width', instance.width);
  return val;
}
