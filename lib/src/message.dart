import 'package:meta/meta.dart';
import 'preview_data.dart' show PreviewData;
import 'util.dart';

/// All possible message types.
enum MessageType { file, image, text }

/// All possible statuses message can have.
enum Status { error, read, sending, sent }

/// An abstract class that contains all variables and methods
/// every message will have.
@immutable
abstract class Message {
  const Message(
    this.authorId,
    this.id,
    this.status,
    this.timestamp,
    this.type,
  )   : assert(authorId != null),
        assert(id != null),
        assert(type != null);

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
        return null;
    }
  }

  /// Converts a particular message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson();

  /// ID of the user who sent this message
  final String authorId;

  /// Unique ID of the message
  final String id;

  /// Message [Status]
  final Status status;

  /// Timestamp in seconds
  final int timestamp;

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
    @required this.fileName,
    this.mimeType,
    @required this.size,
    @required this.uri,
  })  : assert(fileName != null),
        assert(size != null),
        assert(uri != null);

  /// Creates a partial file message from a map (decoded JSON).
  PartialFile.fromJson(Map<String, dynamic> json)
      : fileName = json['fileName'] as String,
        mimeType = json['mimeType'] as String,
        size = json['size']?.round() as int,
        uri = json['uri'] as String;

  /// Converts a partial file message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'fileName': fileName,
        'mimeType': mimeType,
        'size': size,
        'uri': uri,
      };

  /// The name of the file
  final String fileName;

  /// Media type
  final String mimeType;

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
    @required String authorId,
    @required this.fileName,
    @required String id,
    this.mimeType,
    @required this.size,
    Status status,
    int timestamp,
    @required this.uri,
  })  : assert(fileName != null),
        assert(size != null),
        assert(uri != null),
        super(authorId, id, status, timestamp, MessageType.file);

  /// Creates a full file message from a partial one.
  FileMessage.fromPartial(
    String authorId,
    String id,
    PartialFile partialFile, {
    Status status,
    int timestamp,
  })  : fileName = partialFile.fileName,
        mimeType = partialFile.mimeType,
        size = partialFile.size,
        uri = partialFile.uri,
        super(authorId, id, status, timestamp, MessageType.file);

  /// Creates a file message from a map (decoded JSON).
  FileMessage.fromJson(Map<String, dynamic> json)
      : fileName = json['fileName'] as String,
        mimeType = json['mimeType'] as String,
        size = json['size']?.round() as int,
        uri = json['uri'] as String,
        super(
          json['authorId'] as String,
          json['id'] as String,
          getStatusFromString(json['status'] as String),
          json['timestamp'] as int,
          MessageType.file,
        );

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'authorId': authorId,
        'fileName': fileName,
        'id': id,
        'mimeType': mimeType,
        'size': size,
        'status': status,
        'timestamp': timestamp,
        'type': 'file',
        'uri': uri,
      };

  /// The name of the file
  final String fileName;

  /// Media type
  final String mimeType;

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
    @required this.imageName,
    @required this.size,
    @required this.uri,
    this.width,
  })  : assert(imageName != null),
        assert(size != null),
        assert(uri != null);

  /// Creates a partial image message from a map (decoded JSON).
  PartialImage.fromJson(Map<String, dynamic> json)
      : height = json['height'] as double,
        imageName = json['imageName'] as String,
        size = json['size']?.round() as int,
        uri = json['uri'] as String,
        width = json['width'] as double;

  /// Converts a partial image message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'height': height,
        'imageName': imageName,
        'size': size,
        'uri': uri,
        'width': width,
      };

  /// Image height in pixels
  final double height;

  /// The name of the image
  final String imageName;

  /// Size of the image in bytes
  final int size;

  /// The image source (either a remote URL or a local resource)
  final String uri;

  /// Image width in pixels
  final double width;
}

/// A class that represents image message.
@immutable
class ImageMessage extends Message {
  /// Creates an image message.
  const ImageMessage({
    @required String authorId,
    this.height,
    @required String id,
    @required this.imageName,
    @required this.size,
    Status status,
    int timestamp,
    @required this.uri,
    this.width,
  })  : assert(imageName != null),
        assert(size != null),
        assert(uri != null),
        super(authorId, id, status, timestamp, MessageType.image);

  /// Creates a full image message from a partial one.
  ImageMessage.fromPartial(
    String authorId,
    String id,
    PartialImage partialImage, {
    Status status,
    int timestamp,
  })  : height = partialImage.height,
        imageName = partialImage.imageName,
        size = partialImage.size,
        uri = partialImage.uri,
        width = partialImage.width,
        super(authorId, id, status, timestamp, MessageType.image);

  /// Creates an image message from a map (decoded JSON).
  ImageMessage.fromJson(Map<String, dynamic> json)
      : height = json['height']?.toDouble() as double,
        imageName = json['imageName'] as String,
        size = json['size']?.round() as int,
        uri = json['uri'] as String,
        width = json['width']?.toDouble() as double,
        super(
          json['authorId'] as String,
          json['id'] as String,
          getStatusFromString(json['status'] as String),
          json['timestamp'] as int,
          MessageType.image,
        );

  /// Converts an image message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'authorId': authorId,
        'height': height,
        'id': id,
        'imageName': imageName,
        'size': size,
        'status': status,
        'timestamp': timestamp,
        'type': 'image',
        'uri': uri,
        'width': width,
      };

  /// Image height in pixels
  final double height;

  /// The name of the image
  final String imageName;

  /// Size of the image in bytes
  final int size;

  /// The image source (either a remote URL or a local resource)
  final String uri;

  /// Image width in pixels
  final double width;
}

/// A class that represents partial text message.
@immutable
class PartialText {
  /// Creates a partial text message with all variables text can have.
  /// Use [TextMessage] to create a full message.
  /// You can use [TextMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialText({
    @required this.text,
  }) : assert(text != null);

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
    @required String authorId,
    @required String id,
    this.previewData,
    Status status,
    @required this.text,
    int timestamp,
  })  : assert(text != null),
        super(authorId, id, status, timestamp, MessageType.text);

  /// Creates a full text message from a partial one.
  TextMessage.fromPartial(
    String authorId,
    String id,
    PartialText partialText, {
    Status status,
    int timestamp,
  })  : previewData = null,
        text = partialText.text,
        super(authorId, id, status, timestamp, MessageType.text);

  /// Creates a text message from a map (decoded JSON).
  TextMessage.fromJson(Map<String, dynamic> json)
      : previewData = json['previewData'] == null
            ? null
            : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
        text = json['text'] as String,
        super(
          json['authorId'] as String,
          json['id'] as String,
          getStatusFromString(json['status'] as String),
          json['timestamp'] as int,
          MessageType.text,
        );

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'authorId': authorId,
        'id': id,
        'previewData': previewData?.toJson(),
        'status': status,
        'text': text,
        'timestamp': timestamp,
        'type': 'text',
      };

  /// Creates a copy of the text message with an updated preview data
  TextMessage copyWith({
    PreviewData previewData,
  }) {
    return TextMessage(
      authorId: authorId,
      id: id,
      previewData: previewData ?? previewData,
      status: status,
      text: text,
      timestamp: timestamp,
    );
  }

  /// See [PreviewData]
  final PreviewData previewData;

  /// User's message
  final String text;
}
