import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'text_message_translation_state.dart';

part 'text_message_translation_state_translated.g.dart';

/// The language ISO codes for all supported languages.
enum ISOCode {
  /// The ISOCode for Germany.
  de,

  /// The ISOCode for English.
  en,

  /// The ISOCode for Ukraine.
  uk,

  /// The ISOCode for Turkey.
  tr,

  /// The ISOCode for Russia.
  ru,

  /// The ISOCode for Poland.
  pl,

  /// The ISOCode for Czech.
  cs,

  /// The ISOCode for Esperanto.
  eo,

  /// The ISOCode for French.
  fr,

  /// The ISOCode for Italian.
  it,

  /// The ISOCode for Korean.
  ko,

  /// The ISOCode for Portuguese.
  pt,

  /// The ISOCode for Spanish.
  es,

  /// The Orginal Langauge.
  original;

  String languageName() {
    const isoCodeToString = <ISOCode, String>{
      ISOCode.de: 'Deutsch',
      ISOCode.en: 'English',
      ISOCode.uk: 'Українська',
      ISOCode.tr: 'Türkçe',
      ISOCode.ru: 'Русский',
      ISOCode.pl: 'Polski',
      ISOCode.cs: 'Čeština',
      ISOCode.eo: 'Esperanto',
      ISOCode.fr: 'Français',
      ISOCode.it: 'Italiana',
      ISOCode.ko: '한국인',
      ISOCode.pt: 'Português',
      ISOCode.es: 'Española',
      ISOCode.original: 'Original',
    };
    if (isoCodeToString.containsKey(this)) return isoCodeToString[this]!;

    throw Exception(['ISOCode.toString() failed. This should never happen.']);
  }

  @override
  String toString() {
    const isoCodeToString = <ISOCode, String>{
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
    if (isoCodeToString.containsKey(this)) return isoCodeToString[this]!;

    throw Exception(['ISOCode.toString() failed. This should never happen.']);
  }

  /// Get the enum representation of the string.
  static ISOCode fromString(String isoCode) {
    const isoCodeMapping = <String, ISOCode>{
      'de': ISOCode.de,
      'en': ISOCode.en,
      'uk': ISOCode.uk,
      'tr': ISOCode.tr,
      'ru': ISOCode.ru,
      'pl': ISOCode.pl,
      'cs': ISOCode.cs,
      'eo': ISOCode.eo,
      'fr': ISOCode.fr,
      'it': ISOCode.it,
      'ko': ISOCode.ko,
      'pt': ISOCode.pt,
      'es': ISOCode.es,
      'original': ISOCode.original,
    };
    if (isoCodeMapping.containsKey(isoCode)) return isoCodeMapping[isoCode]!;

    throw Exception(['Unknown ISOCode: $isoCode']);
  }
}

/// A class that represents the message translation translated state.
@JsonSerializable()
@immutable
abstract class TextMessageTranslationStateTranslated
    extends TextMessageTranslationState {
  /// Creates a translated translation state.
  const TextMessageTranslationStateTranslated._({
    required this.translations,
  }) : super(type: MessageTranslationStateType.translated);

  const factory TextMessageTranslationStateTranslated({
    required Map<ISOCode, String> translations,
  }) = _TextMessageTranslationStateTranslated;

  /// Creates a translated translation state from a map (decoded JSON).
  factory TextMessageTranslationStateTranslated.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TextMessageTranslationStateTranslatedFromJson(json);

  /// Translations.
  final Map<ISOCode, String> translations;

  /// ISOCode of the original language for a text meesage.
  ISOCode? get originalISOCode {
    try {
      return ISOCode.fromString(translations[ISOCode.original] ?? '');
    } catch (exception) {
      return null;
    }
  }

  /// Equatable props.
  @override
  List<Object?> get props => super.props + [translations];

  /// Converts a translated translation state to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        ..._$TextMessageTranslationStateTranslatedToJson(this),
      };
}

/// A utility class.
class _TextMessageTranslationStateTranslated
    extends TextMessageTranslationStateTranslated {
  const _TextMessageTranslationStateTranslated({required super.translations})
      : super._();
}
