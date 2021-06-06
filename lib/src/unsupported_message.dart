import 'package:meta/meta.dart';
import 'message.dart';
import 'preview_data.dart' show PreviewData;
import 'user.dart' show User;
import 'util.dart' show getStatusFromString;

/// A class that represents unsupported message. Used for backwards
/// compatibility. If chat's end user doesn't update to a new version
/// where new message types are being sent, some of them will result
/// to unsupported.
@immutable
class UnsupportedMessage extends Message {
  /// Creates an unsupported message.
  const UnsupportedMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    String? roomId,
    Status? status,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.unsupported,
        );

  /// Creates an unsupported message from a map (decoded JSON).
  UnsupportedMessage.fromJson(Map<String, dynamic> json)
      : super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as int?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.unsupported,
        );

  /// Converts an unsupported message to the map representation,
  /// encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'createdAt': createdAt,
        'id': id,
        'metadata': metadata,
        'roomId': roomId,
        'status': status,
        'type': 'unsupported',
      };

  /// Creates a copy of the unsupported message with an updated data.
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
    return UnsupportedMessage(
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
      ];
}
