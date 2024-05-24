// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message_translation_state_translated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessageTranslationStateTranslated
    _$TextMessageTranslationStateTranslatedFromJson(
            Map<String, dynamic> json) =>
        TextMessageTranslationStateTranslated(
          translations: (json['translations'] as Map<String, dynamic>).map(
            (k, e) => MapEntry($enumDecode(_$ISOCodeEnumMap, k), e as String),
          ),
        );

Map<String, dynamic> _$TextMessageTranslationStateTranslatedToJson(
        TextMessageTranslationStateTranslated instance) =>
    <String, dynamic>{
      'translations': instance.translations
          .map((k, e) => MapEntry(_$ISOCodeEnumMap[k]!, e)),
    };

const _$ISOCodeEnumMap = {
  ISOCode.de: 'de',
  ISOCode.en: 'en',
  ISOCode.uk: 'uk',
  ISOCode.tr: 'tr',
  ISOCode.ru: 'ru',
  ISOCode.pl: 'pl',
  ISOCode.cs: 'cs',
  ISOCode.eo: 'eo',
  ISOCode.fr: 'fr',
  ISOCode.it: 'it',
  ISOCode.ko: 'ko',
  ISOCode.pt: 'pt',
  ISOCode.es: 'es',
  ISOCode.original: 'original',
};
