import 'package:meta/meta.dart';
import 'message.dart';
import 'partial_text.dart';
import 'preview_data.dart' show PreviewData;
import 'user.dart' show User;
import 'util.dart' show getStatusFromString;

/// A class that represents text message.
@immutable
class TextMessage extends Message {
  /// Creates a text message.
  const TextMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    this.previewData,
    String? roomId,
    Status? status,
    required this.text,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.text,
        );

  /// Creates a full text message from a partial one.
  TextMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialText partialText,
    String? roomId,
    Status? status,
  })  : previewData = null,
        text = partialText.text,
        super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.text,
        );

  /// Creates a text message from a map (decoded JSON).
  TextMessage.fromJson(Map<String, dynamic> json)
      : previewData = json['previewData'] == null
            ? null
            : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
        text = json['text'] as String,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as int?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.text,
        );

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'createdAt': createdAt,
        'id': id,
        'metadata': metadata,
        'previewData': previewData?.toJson(),
        'roomId': roomId,
        'status': status?.toShortString(),
        'text': text,
        'type': MessageType.text.toShortString(),
      };

  /// Creates a copy of the text message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [status] with null value will be overwritten by the previous status.
  @override
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
  }) {
    return TextMessage(
      author: author,
      createdAt: createdAt,
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      previewData: previewData,
      roomId: roomId,
      status: status ?? this.status,
      text: text ?? this.text,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props =>
      [author, createdAt, id, metadata, previewData, roomId, status, text];

  /// See [PreviewData]
  final PreviewData? previewData;

  /// User's message
  final String text;
}
