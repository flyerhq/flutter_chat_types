import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'text_message_translation_state.dart';

part 'text_message_translation_state_failed.g.dart';

/// A class that represents the message translation failed state.
@JsonSerializable()
@immutable
abstract class TextMessageTranslationStateFailed
    extends TextMessageTranslationState {
  /// Creates a failed translation state.
  const TextMessageTranslationStateFailed._({this.error})
      : super(type: MessageTranslationStateType.failed);

  const factory TextMessageTranslationStateFailed({String? error}) =
      _TextMessageTranslationStateFailed;

  /// Creates a failed translation state from a map (decoded JSON).
  factory TextMessageTranslationStateFailed.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TextMessageTranslationStateFailedFromJson(json);

  /// Error message.
  final String? error;

  /// Converts a failed translation state to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        ..._$TextMessageTranslationStateFailedToJson(this),
      };
}

/// A utility class.
class _TextMessageTranslationStateFailed
    extends TextMessageTranslationStateFailed {
  const _TextMessageTranslationStateFailed({super.error}) : super._();
}
