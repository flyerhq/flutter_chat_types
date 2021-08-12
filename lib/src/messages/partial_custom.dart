import 'package:meta/meta.dart';
import 'custom_message.dart';

/// A class that represents partial custom message.
@immutable
class PartialCustom {
  /// Creates a partial custom message with metadata variable.
  /// Use [CustomMessage] to create a full message.
  /// You can use [CustomMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialCustom({
    this.metadata,
  });

  /// Creates a partial custom message from a map (decoded JSON).
  PartialCustom.fromJson(Map<String, dynamic> json)
      : metadata = json['metadata'] as Map<String, dynamic>?;

  /// Converts a partial custom message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'metadata': metadata,
      };

  /// Additional custom metadata or attributes related to the message
  final Map<String, dynamic>? metadata;
}
