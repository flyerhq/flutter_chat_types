import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import 'partial_text.dart';

part 'text_message.g.dart';

/// A class that represents text message.
@JsonSerializable()
@immutable
abstract class TextMessage extends Message {
  /// Creates a text message.
  const TextMessage._({
    required super.author,
    super.createdAt,
    required super.id,
    super.metadata,
    this.previewData,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    required this.text,
    MessageType? type,
    super.updatedAt,
  }) : super(type: type ?? MessageType.text);

  const factory TextMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    Status? status,
    required String text,
    MessageType? type,
    int? updatedAt,
  }) = _TextMessage;

  /// Creates a full text message from a partial one.
  TextMessage.fromPartial({
    required super.author,
    super.createdAt,
    required super.id,
    required PartialText partialText,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    super.updatedAt,
  })  : previewData = partialText.previewData,
        text = partialText.text,
        super(metadata: partialText.metadata, type: MessageType.text);

  /// Creates a text message from a map (decoded JSON).
  factory TextMessage.fromJson(Map<String, dynamic> json) =>
      _$TextMessageFromJson(json);

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);

  @override
  Message copyWith({
    User? author,
    int? createdAt,
    String? id,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    Status? status,
    String? text,
    int? updatedAt,
  });

  /// Equatable props
  @override
  List<Object?> get props => [
        author,
        createdAt,
        id,
        metadata,
        previewData,
        remoteId,
        repliedMessage,
        roomId,
        status,
        text,
        updatedAt,
      ];

  /// See [PreviewData]
  final PreviewData? previewData;

  /// User's message
  final String text;
}

/// A utility class to enable better copyWith
class _TextMessage extends TextMessage {
  const _TextMessage({
    required super.author,
    super.createdAt,
    required super.id,
    super.metadata,
    super.previewData,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    required super.text,
    super.type,
    super.updatedAt,
  }) : super._();

  @override
  Message copyWith({
    User? author,
    dynamic createdAt = _Unset,
    String? id,
    dynamic metadata = _Unset,
    dynamic previewData = _Unset,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    dynamic status = _Unset,
    String? text,
    dynamic updatedAt = _Unset,
  }) =>
      _TextMessage(
        author: author ?? this.author,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        id: id ?? this.id,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        previewData: previewData == _Unset
            ? this.previewData
            : previewData as PreviewData?,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        status: status == _Unset ? this.status : status as Status?,
        text: text ?? this.text,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
      );
}

class _Unset {}
