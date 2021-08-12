import 'package:meta/meta.dart';
import '../preview_data.dart' show PreviewData;
import 'text_message.dart';

/// A class that represents partial text message.
@immutable
class PartialText {
  /// Creates a partial text message with all variables text can have.
  /// Use [TextMessage] to create a full message.
  /// You can use [TextMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialText({
    this.metadata,
    this.previewData,
    required this.text,
  });

  /// Creates a partial text message from a map (decoded JSON).
  PartialText.fromJson(Map<String, dynamic> json)
      : metadata = json['metadata'] as Map<String, dynamic>?,
        previewData = json['previewData'] == null
            ? null
            : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
        text = json['text'] as String;

  /// Converts a partial text message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'metadata': metadata,
        'previewData': previewData?.toJson(),
        'text': text,
      };

  /// Additional custom metadata or attributes related to the message
  final Map<String, dynamic>? metadata;

  /// See [PreviewData]
  final PreviewData? previewData;

  /// User's message
  final String text;
}
