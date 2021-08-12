import 'package:meta/meta.dart';
import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import '../util.dart' show getStatusFromString;
import 'partial_image.dart';

/// A class that represents image message.
@immutable
class ImageMessage extends Message {
  /// Creates an image message.
  const ImageMessage({
    required User author,
    int? createdAt,
    this.height,
    required String id,
    Map<String, dynamic>? metadata,
    required this.name,
    String? roomId,
    required this.size,
    Status? status,
    int? updatedAt,
    required this.uri,
    this.width,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.image,
          updatedAt,
        );

  /// Creates a full image message from a partial one.
  ImageMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    required PartialImage partialImage,
    String? roomId,
    Status? status,
    int? updatedAt,
  })  : height = partialImage.height,
        name = partialImage.name,
        size = partialImage.size,
        uri = partialImage.uri,
        width = partialImage.width,
        super(
          author,
          createdAt,
          id,
          partialImage.metadata,
          roomId,
          status,
          MessageType.image,
          updatedAt,
        );

  /// Creates an image message from a map (decoded JSON).
  ImageMessage.fromJson(Map<String, dynamic> json)
      : height = json['height']?.toDouble() as double?,
        name = json['name'] as String,
        size = json['size'].round() as int,
        uri = json['uri'] as String,
        width = json['width']?.toDouble() as double?,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as int?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.image,
          json['updatedAt'] as int?,
        );

  /// Converts an image message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'createdAt': createdAt,
        'height': height,
        'id': id,
        'metadata': metadata,
        'name': name,
        'roomId': roomId,
        'size': size,
        'status': status?.toShortString(),
        'type': MessageType.image.toShortString(),
        'updatedAt': updatedAt,
        'uri': uri,
        'width': width,
      };

  /// Creates a copy of the image message with an updated data
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
    return ImageMessage(
      author: author,
      createdAt: createdAt,
      height: height,
      id: id,
      name: name,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      roomId: roomId,
      size: size,
      status: status ?? this.status,
      updatedAt: updatedAt,
      uri: uri,
      width: width,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        author,
        createdAt,
        height,
        id,
        metadata,
        name,
        roomId,
        size,
        status,
        updatedAt,
        uri,
        width,
      ];

  /// Image height in pixels
  final double? height;

  /// The name of the image
  final String name;

  /// Size of the image in bytes
  final int size;

  /// The image source (either a remote URL or a local resource)
  final String uri;

  /// Image width in pixels
  final double? width;
}
