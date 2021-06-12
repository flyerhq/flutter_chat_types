import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'custom_message.dart';
import 'file_message.dart';
import 'image_message.dart';
import 'preview_data.dart' show PreviewData;
import 'text_message.dart';
import 'unsupported_message.dart';
import 'user.dart' show User;

/// All possible message types.
enum MessageType { custom, file, image, text, unsupported }

/// Extension with one [toShortString] method
extension MessageTypeToShortString on MessageType {
  /// Converts enum to the string equal to enum's name
  String toShortString() {
    return toString().split('.').last;
  }
}

/// All possible statuses message can have.
enum Status { delivered, error, seen, sending, sent }

/// Extension with one [toShortString] method
extension StatusToShortString on Status {
  /// Converts enum to the string equal to enum's name
  String toShortString() {
    return toString().split('.').last;
  }
}

/// An abstract class that contains all variables and methods
/// every message will have.
@immutable
abstract class Message extends Equatable {
  const Message(
    this.author,
    this.createdAt,
    this.id,
    this.metadata,
    this.roomId,
    this.status,
    this.type,
  );

  /// Creates a particular message from a map (decoded JSON).
  /// Type is determined by the `type` field.
  factory Message.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'custom':
        return CustomMessage.fromJson(json);
      case 'file':
        return FileMessage.fromJson(json);
      case 'image':
        return ImageMessage.fromJson(json);
      case 'text':
        return TextMessage.fromJson(json);
      default:
        return UnsupportedMessage.fromJson(json);
    }
  }

  /// Creates a copy of the message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [previewData] will be only set for the text message type.
  /// [status] with null value will be overwritten by the previous status.
  /// [text] will be only set for the text message type. Null value will be
  /// overwritten by the previous text (can't be empty).
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
  });

  /// Converts a particular message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson();

  /// User who sent this message
  final User author;

  /// Created message timestamp, in ms
  final int? createdAt;

  /// Unique ID of the message
  final String id;

  /// Additional custom metadata or attributes related to the message
  final Map<String, dynamic>? metadata;

  /// ID of the room where this message is sent
  final String? roomId;

  /// Message [Status]
  final Status? status;

  /// [MessageType]
  final MessageType type;
}
