import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:meta/meta.dart';
import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import '../util.dart' show getStatusFromString;

/// A class that represents file message.
@immutable
class VoiceMessage extends Message {
  /// Creates a file message.
  const VoiceMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    this.mimeType,
    required this.name,
    String? roomId,
    required this.size,
    Status? status,
    int? updatedAt,
    required this.uri,
    required this.duration,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.voice,
          updatedAt,
        );

  /// Creates a full file message from a partial one.
  VoiceMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialVoice partialVoice,
    String? roomId,
    Status? status,
    int? updatedAt,
  })  : mimeType = partialVoice.mimeType,
        name = partialVoice.name,
        size = partialVoice.size,
        uri = partialVoice.uri,
        duration = partialVoice.duration,
        super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.voice,
          updatedAt,
        );

  /// Creates a file message from a map (decoded JSON).
  VoiceMessage.fromJson(Map<String, dynamic> json)
      : mimeType = json['mimeType'] as String?,
        name = json['name'] as String,
        size = json['size'].round() as int,
        uri = json['uri'] as String,
        duration = json['duration'] as Duration,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as int?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.voice,
          json['updatedAt'] as int?,
        );

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'createdAt': createdAt,
        'id': id,
        'metadata': metadata,
        'mimeType': mimeType,
        'name': name,
        'roomId': roomId,
        'size': size,
        'status': status?.toShortString(),
        'type': MessageType.voice.toShortString(),
        'updatedAt': updatedAt,
        'uri': uri,
        'duration': duration,
      };

  /// Creates a copy of the file message with an updated data.
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [previewData] is ignored for this message type.
  /// [status] with null value will be overwritten by the previous status.
  /// [text] is ignored for this message type.
  /// [updatedAt] with null value will nullify existing value.
  @override
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
    int? updatedAt,
  }) {
    return VoiceMessage(
      author: author,
      createdAt: createdAt,
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      mimeType: mimeType,
      name: name,
      roomId: roomId,
      size: size,
      status: status ?? this.status,
      updatedAt: updatedAt,
      uri: uri,
      duration: duration,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        author,
        createdAt,
        id,
        metadata,
        mimeType,
        name,
        roomId,
        size,
        status,
        updatedAt,
        uri,
        duration,
      ];

  /// Media type
  final String? mimeType;

  /// The name of the file
  final String name;

  /// Size of the file in bytes
  final int size;

  /// The file source (either a remote URL or a local resource)
  final String uri;

  final Duration duration;
}
