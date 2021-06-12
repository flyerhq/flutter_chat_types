import 'package:meta/meta.dart';
import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import '../util.dart' show getStatusFromString;
import 'partial_file.dart';

/// A class that represents file message.
@immutable
class FileMessage extends Message {
  /// Creates a file message.
  const FileMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    this.mimeType,
    required this.name,
    String? roomId,
    required this.size,
    Status? status,
    required this.uri,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.file,
        );

  /// Creates a full file message from a partial one.
  FileMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialFile partialFile,
    String? roomId,
    Status? status,
  })  : mimeType = partialFile.mimeType,
        name = partialFile.name,
        size = partialFile.size,
        uri = partialFile.uri,
        super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.file,
        );

  /// Creates a file message from a map (decoded JSON).
  FileMessage.fromJson(Map<String, dynamic> json)
      : mimeType = json['mimeType'] as String?,
        name = json['name'] as String,
        size = json['size'].round() as int,
        uri = json['uri'] as String,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as int?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.file,
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
        'type': MessageType.file.toShortString(),
        'uri': uri,
      };

  /// Creates a copy of the file message with an updated data.
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [previewData] is ignored for this message type.
  /// [status] with null value will be overwritten by the previous status.
  /// [text] is ignored for this message type.
  @override
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
  }) {
    return FileMessage(
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
      uri: uri,
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
        uri,
      ];

  /// Media type
  final String? mimeType;

  /// The name of the file
  final String name;

  /// Size of the file in bytes
  final int size;

  /// The file source (either a remote URL or a local resource)
  final String uri;
}
