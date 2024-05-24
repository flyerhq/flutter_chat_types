// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message_translation_state_unsupported.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessageTranslationStateUnsupported
    _$TextMessageTranslationStateUnsupportedFromJson(
            Map<String, dynamic> json) =>
        TextMessageTranslationStateUnsupported(
          isoCode: json['isoCode'] as String?,
        );

Map<String, dynamic> _$TextMessageTranslationStateUnsupportedToJson(
    TextMessageTranslationStateUnsupported instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isoCode', instance.isoCode);
  return val;
}
