import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:meta/meta.dart';
import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import 'partial_custom.dart';


/// A class that represents custom message. Use [metadata] to store anything
/// you want.
@immutable
class CustomMessage extends Message {
  /// Creates a custom message.
  const CustomMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    String? roomId,
    Status? status,
    MessageType? type,
    int? updatedAt,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          type ?? MessageType.custom,
          updatedAt,
        );

  /// Creates a full custom message from a partial one.
  CustomMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    required PartialCustom partialCustom,
    String? roomId,
    Status? status,
    int? updatedAt,
  }) : super(
          author,
          createdAt,
          id,
          partialCustom.metadata,
          roomId,
          status,
          MessageType.custom,
          updatedAt,
        );

  CustomMessage.fromJson(Map<String, dynamic> json)
      : super(
        User.fromJson(json['author'] as Map<String, dynamic>),
        json['createdAt'] as int?,
        json['id'] as String,
        json['metadata'] as Map<String, dynamic>?,
        json['roomId'] as String?,
        getStatusFromString(json['status'] as String?),
        MessageType.file,
        json['updatedAt'] as int?,
      );

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
    'author': author.toJson(),
    'createdAt': createdAt,
    'id': id,
    'metadata': metadata,
    'roomId': roomId,
    'status': status?.toShortString(),
    'type': MessageType.file.toShortString(),
    'updatedAt': updatedAt,
  };

  /// Creates a copy of the custom message with an updated data.
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
    return CustomMessage(
      author: author,
      createdAt: createdAt,
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      roomId: roomId,
      status: status ?? this.status,
      updatedAt: updatedAt,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        author,
        createdAt,
        id,
        metadata,
        roomId,
        status,
        updatedAt,
      ];
}
