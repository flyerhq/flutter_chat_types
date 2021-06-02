import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'preview_data.dart' show PreviewData;
import 'user.dart';
import 'util.dart';

/// All possible message types.
enum MessageType { file, image, text }

/// All possible statuses message can have.
enum Status { delivered, error, read, sending }

/// An abstract class that contains all variables and methods
/// every message will have.
@immutable
abstract class Message extends Equatable {
  const Message(
    this.author,
    this.id,
    this.metadata,
    this.status,
    this.timestamp,
    this.type,
  );

  /// Creates a particular message from a map (decoded JSON).
  /// Type is determined by the `type` field.
  factory Message.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'file':
        return FileMessage.fromJson(json);
      case 'image':
        return ImageMessage.fromJson(json);
      case 'text':
        return TextMessage.fromJson(json);
      default:
        throw ArgumentError('Unexpected value for message type');
    }
  }

  /// Creates a copy of the message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [previewData] will be only set for the text message type.
  /// [status] with null value will be overwritten by the previous status.
  /// [text] will be only set for the text message type. Null value will be
  /// overwritten by the previous text (can't be empty).
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
  });

  /// Converts a particular message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson();

  /// User who sent this message
  final User author;

  /// Unique ID of the message
  final String id;

  /// Additional custom metadata or attributes related to the message
  final Map<String, dynamic>? metadata;

  /// Message [Status]
  final Status? status;

  /// Timestamp in ms
  final int? timestamp;

  /// [MessageType]
  final MessageType type;
}

/// A class that represents partial file message.
@immutable
class PartialFile {
  /// Creates a partial file message with all variables file can have.
  /// Use [FileMessage] to create a full message.
  /// You can use [FileMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialFile({
    this.mimeType,
    required this.name,
    required this.size,
    required this.uri,
  });

  /// Creates a partial file message from a map (decoded JSON).
  PartialFile.fromJson(Map<String, dynamic> json)
      : mimeType = json['mimeType'] as String?,
        name = json['name'] as String,
        size = json['size'].round() as int,
        uri = json['uri'] as String;

  /// Converts a partial file message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'mimeType': mimeType,
        'name': name,
        'size': size,
        'uri': uri,
      };

  /// Media type
  final String? mimeType;

  /// The name of the file
  final String name;

  /// Size of the file in bytes
  final int size;

  /// The file source (either a remote URL or a local resource)
  final String uri;
}

/// A class that represents file message.
@immutable
class FileMessage extends Message {
  /// Creates a file message.
  const FileMessage({
    required User author,
    required String id,
    Map<String, dynamic>? metadata,
    this.mimeType,
    required this.name,
    required this.size,
    Status? status,
    int? timestamp,
    required this.uri,
  }) : super(author, id, metadata, status, timestamp, MessageType.file);

  /// Creates a full file message from a partial one.
  FileMessage.fromPartial({
    required User author,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialFile partialFile,
    Status? status,
    int? timestamp,
  })  : mimeType = partialFile.mimeType,
        name = partialFile.name,
        size = partialFile.size,
        uri = partialFile.uri,
        super(author, id, metadata, status, timestamp, MessageType.file);

  /// Creates a file message from a map (decoded JSON).
  FileMessage.fromJson(Map<String, dynamic> json)
      : mimeType = json['mimeType'] as String?,
        name = json['name'] as String,
        size = json['size'].round() as int,
        uri = json['uri'] as String,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          getStatusFromString(json['status'] as String?),
          json['timestamp'] as int?,
          MessageType.file,
        );

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'id': id,
        'metadata': metadata,
        'mimeType': mimeType,
        'name': name,
        'size': size,
        'status': status,
        'timestamp': timestamp,
        'type': 'file',
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
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      mimeType: mimeType,
      name: name,
      size: size,
      status: status ?? this.status,
      timestamp: timestamp,
      uri: uri,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        author,
        id,
        metadata,
        mimeType,
        name,
        size,
        status,
        timestamp,
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

/// A class that represents partial image message.
@immutable
class PartialImage {
  /// Creates a partial image message with all variables image can have.
  /// Use [ImageMessage] to create a full message.
  /// You can use [ImageMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialImage({
    this.height,
    required this.name,
    required this.size,
    required this.uri,
    this.width,
  });

  /// Creates a partial image message from a map (decoded JSON).
  PartialImage.fromJson(Map<String, dynamic> json)
      : height = json['height']?.toDouble() as double?,
        name = json['name'] as String,
        size = json['size'].round() as int,
        uri = json['uri'] as String,
        width = json['width']?.toDouble() as double?;

  /// Converts a partial image message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'height': height,
        'name': name,
        'size': size,
        'uri': uri,
        'width': width,
      };

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

/// A class that represents image message.
@immutable
class ImageMessage extends Message {
  /// Creates an image message.
  const ImageMessage({
    required User author,
    this.height,
    required String id,
    Map<String, dynamic>? metadata,
    required this.name,
    required this.size,
    Status? status,
    int? timestamp,
    required this.uri,
    this.width,
  }) : super(author, id, metadata, status, timestamp, MessageType.image);

  /// Creates a full image message from a partial one.
  ImageMessage.fromPartial({
    required User author,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialImage partialImage,
    Status? status,
    int? timestamp,
  })  : height = partialImage.height,
        name = partialImage.name,
        size = partialImage.size,
        uri = partialImage.uri,
        width = partialImage.width,
        super(author, id, metadata, status, timestamp, MessageType.image);

  /// Creates an image message from a map (decoded JSON).
  ImageMessage.fromJson(Map<String, dynamic> json)
      : height = json['height']?.toDouble() as double?,
        name = json['name'] as String,
        size = json['size'].round() as int,
        uri = json['uri'] as String,
        width = json['width']?.toDouble() as double?,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          getStatusFromString(json['status'] as String?),
          json['timestamp'] as int?,
          MessageType.image,
        );

  /// Converts an image message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'height': height,
        'id': id,
        'metadata': metadata,
        'name': name,
        'size': size,
        'status': status,
        'timestamp': timestamp,
        'type': 'image',
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
  @override
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
  }) {
    return ImageMessage(
      author: author,
      height: height,
      id: id,
      name: name,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      size: size,
      status: status ?? this.status,
      timestamp: timestamp,
      uri: uri,
      width: width,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        author,
        height,
        id,
        metadata,
        name,
        size,
        status,
        timestamp,
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

/// A class that represents partial text message.
@immutable
class PartialText {
  /// Creates a partial text message with all variables text can have.
  /// Use [TextMessage] to create a full message.
  /// You can use [TextMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialText({
    required this.text,
  });

  /// Creates a partial text message from a map (decoded JSON).
  PartialText.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String;

  /// Converts a partial text message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'text': text,
      };

  /// User's message
  final String text;
}

/// A class that represents text message.
@immutable
class TextMessage extends Message {
  /// Creates a text message.
  const TextMessage({
    required User author,
    required String id,
    Map<String, dynamic>? metadata,
    this.previewData,
    Status? status,
    required this.text,
    int? timestamp,
  }) : super(author, id, metadata, status, timestamp, MessageType.text);

  /// Creates a full text message from a partial one.
  TextMessage.fromPartial({
    required User author,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialText partialText,
    Status? status,
    int? timestamp,
  })  : previewData = null,
        text = partialText.text,
        super(author, id, metadata, status, timestamp, MessageType.text);

  /// Creates a text message from a map (decoded JSON).
  TextMessage.fromJson(Map<String, dynamic> json)
      : previewData = json['previewData'] == null
            ? null
            : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
        text = json['text'] as String,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          getStatusFromString(json['status'] as String?),
          json['timestamp'] as int?,
          MessageType.text,
        );

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'id': id,
        'metadata': metadata,
        'previewData': previewData?.toJson(),
        'status': status,
        'text': text,
        'timestamp': timestamp,
        'type': 'text',
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
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      previewData: previewData,
      status: status ?? this.status,
      text: text ?? this.text,
      timestamp: timestamp,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props =>
      [author, id, metadata, previewData, status, text, timestamp];

  /// See [PreviewData]
  final PreviewData? previewData;

  /// User's message
  final String text;
}
