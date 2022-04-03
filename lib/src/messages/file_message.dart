import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import 'partial_file.dart';

part 'file_message.g.dart';

/// A class that represents file message.
@JsonSerializable()
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
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    required this.size,
    Status? status,
    MessageType? type,
    int? updatedAt,
    required this.uri,
    bool showStatus = true,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          remoteId,
          repliedMessage,
          roomId,
          status,
          type ?? MessageType.file,
          updatedAt,
        );

  /// Creates a full file message from a partial one.
  FileMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    required PartialFile partialFile,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    Status? status,
    int? updatedAt,
    bool showStatus = true,
  })  : mimeType = partialFile.mimeType,
        name = partialFile.name,
        size = partialFile.size,
        uri = partialFile.uri,
        super(
          author,
          createdAt,
          id,
          partialFile.metadata,
          remoteId,
          repliedMessage,
          roomId,
          status,
          MessageType.file,
          updatedAt,
          showStatus:showStatus,
        );

  /// Creates a file message from a map (decoded JSON).
  factory FileMessage.fromJson(Map<String, dynamic> json) =>
      _$FileMessageFromJson(json);

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$FileMessageToJson(this);

  /// Creates a copy of the file message with an updated data.
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [previewData] is ignored for this message type.
  /// [remoteId] and [updatedAt] with null values will nullify existing value.
  /// [status] and [uri] with null values will be overwritten by previous values.
  /// [text] is ignored for this message type.
  @override
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    Status? status,
    bool? showStatus,
    String? text,
    int? updatedAt,
    String? uri,
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
      remoteId: remoteId,
      repliedMessage: repliedMessage,
      roomId: roomId,
      size: size,
      status: status ?? this.status,
      showStatus: showStatus?? this.showStatus,
      updatedAt: updatedAt,
      uri: uri ?? this.uri,
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
        remoteId,
        repliedMessage,
        roomId,
        size,
        status,
        updatedAt,
        uri,
      ];

  /// Media type
  final String? mimeType;

  /// The name of the file
  final String name;

  /// Size of the file in bytes
  final num size;

  /// The file source (either a remote URL or a local resource)
  final String uri;
}
