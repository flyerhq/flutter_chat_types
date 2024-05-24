import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'text_message_translation_state_empty.dart';
import 'text_message_translation_state_failed.dart';
import 'text_message_translation_state_processing.dart';
import 'text_message_translation_state_translated.dart';
import 'text_message_translation_state_unsupported.dart';

/// All possible message translation state types.
enum MessageTranslationStateType {
  /// Translation has not been started.
  empty,

  /// The translation is going now.
  processing,

  /// The translation was successful.
  translated,

  /// Translation from the original language is not supported.
  unsupported,

  /// Translation failed.
  failed;

  @override
  String toString() {
    switch (this) {
      case MessageTranslationStateType.empty:
        return 'empty';
      case MessageTranslationStateType.processing:
        return 'processing';
      case MessageTranslationStateType.translated:
        return 'translated';
      case MessageTranslationStateType.unsupported:
        return 'unsupported';
      case MessageTranslationStateType.failed:
        return 'failed';
    }
  }
}

/// A class that represent the state of the message translation.
@JsonSerializable()
@immutable
abstract class TextMessageTranslationState extends Equatable {
  const TextMessageTranslationState({required this.type});

  /// Creates a particular TextMessageTranslationState from a map (decoded JSON).
  /// Type is determined by the `type` field.
  factory TextMessageTranslationState.fromJson(Map<String, dynamic> json) {
    final type = MessageTranslationStateType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => MessageTranslationStateType.empty,
    );

    switch (type) {
      case MessageTranslationStateType.processing:
        return const TextMessageTranslationStateProcessing();

      case MessageTranslationStateType.failed:
        return TextMessageTranslationStateFailed.fromJson(json);

      case MessageTranslationStateType.unsupported:
        return TextMessageTranslationStateUnsupported.fromJson(json);

      case MessageTranslationStateType.translated:
        return TextMessageTranslationStateTranslated.fromJson(json);

      default:
        return const TextMessageTranslationStateEmpty();
    }
  }

  /// The state type of the translation state.
  final MessageTranslationStateType type;

  List<Object?> get props => [type];

  /// Converts a particular message to the map representation, serializable to JSON.
  Map<String, dynamic> toJson() => {'type': type.toString()};
}
