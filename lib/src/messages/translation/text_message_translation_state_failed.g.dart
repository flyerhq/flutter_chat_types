// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message_translation_state_failed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessageTranslationStateFailed _$TextMessageTranslationStateFailedFromJson(
        Map<String, dynamic> json) =>
    TextMessageTranslationStateFailed(
      error: json['error'] as String?,
    );

Map<String, dynamic> _$TextMessageTranslationStateFailedToJson(
    TextMessageTranslationStateFailed instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('error', instance.error);
  return val;
}
