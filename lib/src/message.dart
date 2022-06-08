import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'messages/custom_message.dart';
import 'messages/file_message.dart';
import 'messages/image_message.dart';
import 'messages/text_message.dart';
import 'messages/unsupported_message.dart';
import 'preview_data.dart' show PreviewData;
import 'user.dart' show User;

/// All possible message types.
enum MessageType { custom, file, image, text, unsupported }

/// All possible statuses message can have.
enum Status { delivered, error, seen, sending, sent }

/// An abstract class that contains all variables and methods
/// every message will have.
@immutable
abstract class Message extends Equatable {
  const Message({
    required this.author,
    this.createdAt,
    required this.id,
    this.metadata,
    this.remoteId,
    this.repliedMessage,
    this.roomId,
    this.showStatus,
    this.status,
    required this.type,
    this.updatedAt,
  });

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
  /// [isLoading] will be only set for the file message type.
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwrite keys from the previous one.
  /// [previewData] will be only set for the text message type.
  /// [remoteId], [showStatus] and [updatedAt] with null values will nullify existing value.
  /// [author], [createdAt] and [status] with null values will be overwritten by the previous values.
  /// [text] will be only set for the text message type. Null value will be
  /// overwritten by the previous text (can't be empty).
  /// [uri] will be only set for file and image message types. Null value
  /// will be overwritten by the previous value (uri can't be empty).
  Message copyWith({
    User? author,
    int? createdAt,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    bool? showStatus,
    Status? status,
    String? text,
    int? updatedAt,
    String? uri,
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

  /// Unique ID of the message received from the backend
  final String? remoteId;

  /// Message that is being replied to with the current message
  final Message? repliedMessage;

  /// ID of the room where this message is sent
  final String? roomId;

  /// Show status or not
  final bool? showStatus;

  /// Message [Status]
  final Status? status;

  /// [MessageType]
  final MessageType type;

  /// Updated message timestamp, in ms
  final int? updatedAt;
}
