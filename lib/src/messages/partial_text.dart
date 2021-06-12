import 'package:meta/meta.dart';
import 'text_message.dart';

/// A class that represents partial text message.
@immutable
class PartialText {
  /// Creates a partial text message with all variables text can have.
  /// Use [TextMessage] to create a full message.
  /// You can use [TextMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialText({
    required this.text,
  });

  /// Creates a partial text message from a map (decoded JSON).
  PartialText.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String;

  /// Converts a partial text message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'text': text,
      };

  /// User's message
  final String text;
}
