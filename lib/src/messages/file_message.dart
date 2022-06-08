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
    required super.author,
    super.createdAt,
    required super.id,
    this.isLoading,
    super.metadata,
    this.mimeType,
    required this.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required this.size,
    super.status,
    MessageType? type,
    super.updatedAt,
    required this.uri,
  }) : super(type: type ?? MessageType.file);

  /// Creates a full file message from a partial one.
  FileMessage.fromPartial({
    required super.author,
    super.createdAt,
    required super.id,
    this.isLoading,
    required PartialFile partialFile,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    super.updatedAt,
  })  : mimeType = partialFile.mimeType,
        name = partialFile.name,
        size = partialFile.size,
        uri = partialFile.uri,
        super(metadata: partialFile.metadata, type: MessageType.file);

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
  /// [isLoading], [remoteId], [showStatus] and [updatedAt] with null values will nullify existing value.
  /// [author], [createdAt], [status] and [uri] with null values will be overwritten by previous values.
  /// [text] is ignored for this message type.
  @override
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
  }) {
    return FileMessage(
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      id: id,
      isLoading: isLoading,
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
      showStatus: showStatus,
      size: size,
      status: status ?? this.status,
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
        isLoading,
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

  /// Specify whether the message content is currently being loaded
  final bool? isLoading;

  /// Media type
  final String? mimeType;

  /// The name of the file
  final String name;

  /// Size of the file in bytes
  final num size;

  /// The file source (either a remote URL or a local resource)
  final String uri;
}
