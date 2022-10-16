// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialAudio _$PartialAudioFromJson(Map<String, dynamic> json) => PartialAudio(
      duration: Duration(microseconds: json['duration'] as int),
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      size: json['size'] as num,
      uri: json['uri'] as String,
      waveForm: (json['waveForm'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      mimeType: json['mimeType'] as String?,
    );

Map<String, dynamic> _$PartialAudioToJson(PartialAudio instance) {
  final val = <String, dynamic>{
    'duration': instance.duration.inMicroseconds,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mimeType', instance.mimeType);
  writeNotNull('waveForm', instance.waveForm);
  val['uri'] = instance.uri;
  val['name'] = instance.name;
  val['size'] = instance.size;
  writeNotNull('metadata', instance.metadata);
  writeNotNull('repliedMessage', instance.repliedMessage?.toJson());
  return val;
}
