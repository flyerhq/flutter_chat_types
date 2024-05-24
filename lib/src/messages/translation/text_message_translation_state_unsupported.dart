import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'text_message_translation_state.dart';

part 'text_message_translation_state_unsupported.g.dart';

/// A class that represents the message translation unsupported state.
@JsonSerializable()
@immutable
abstract class TextMessageTranslationStateUnsupported
    extends TextMessageTranslationState {
  /// Creates a unsupported translation state.
  const TextMessageTranslationStateUnsupported._({this.isoCode})
      : super(type: MessageTranslationStateType.unsupported);

  const factory TextMessageTranslationStateUnsupported({String? isoCode}) =
      _TextMessageTranslationStateUnsupported;

  /// Creates a text message from a map (decoded JSON).
  factory TextMessageTranslationStateUnsupported.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TextMessageTranslationStateUnsupportedFromJson(json);

  final String? isoCode;

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        ..._$TextMessageTranslationStateUnsupportedToJson(this),
      };
}

///
class _TextMessageTranslationStateUnsupported
    extends TextMessageTranslationStateUnsupported {
  const _TextMessageTranslationStateUnsupported({super.isoCode}) : super._();
}
