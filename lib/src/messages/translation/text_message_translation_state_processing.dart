import 'package:meta/meta.dart';
import 'text_message_translation_state.dart';

/// A class that represents the message translation processing state.
@immutable
abstract class TextMessageTranslationStateProcessing
    extends TextMessageTranslationState {
  /// Creates a processing translation state.
  const TextMessageTranslationStateProcessing._()
      : super(type: MessageTranslationStateType.processing);

  const factory TextMessageTranslationStateProcessing() =
      _TextMessageTranslationStateProcessing;
}

/// A utility class.
class _TextMessageTranslationStateProcessing
    extends TextMessageTranslationStateProcessing {
  const _TextMessageTranslationStateProcessing() : super._();
}
