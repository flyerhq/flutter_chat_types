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

  final String authorId;
  final String id;
  final Status status;
  final int timestamp;
  final MessageType type;

  factory Message.fromJson(Map<String, dynamic> json) {
    final String type = json['type'];

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

  Map<String, dynamic> toJson();
}

/// A class that represents file message.
@immutable
class FileMessage extends Message {
  const FileMessage({
    @required String authorId,
    @required this.fileName,
    @required String id,
    this.mimeType,
    @required this.size,
    Status status,
    int timestamp,
    @required this.url,
  })  : assert(fileName != null),
        assert(size != null),
        assert(url != null),
        super(authorId, id, status, timestamp, MessageType.file);

  FileMessage.fromPartial(
    String authorId,
    String id,
    PartialFile partialFile, {
    Status status,
    int timestamp,
  })  : this.fileName = partialFile.fileName,
        this.mimeType = partialFile.mimeType,
        this.size = partialFile.size,
        this.url = partialFile.url,
        super(authorId, id, status, timestamp, MessageType.file);

  final String fileName;
  final String mimeType;
  final int size;
  final String url;

  FileMessage.fromJson(Map<String, dynamic> json)
      : fileName = json['fileName'],
        mimeType = json['mimeType'],
        size = json['size']?.round(),
        url = json['url'],
        super(
          json['authorId'],
          json['id'],
          getStatusFromString(json['status']),
          json['timestamp'],
          MessageType.file,
        );

  Map<String, dynamic> toJson() => {
        'authorId': authorId,
        'fileName': fileName,
        'id': id,
        'mimeType': mimeType,
        'size': size,
        'status': status,
        'timestamp': timestamp,
        'type': 'file',
        'url': url,
      };
}

/// A class that represents image message.
@immutable
class ImageMessage extends Message {
  const ImageMessage({
    @required String authorId,
    this.height,
    @required String id,
    @required this.imageName,
    @required this.size,
    Status status,
    int timestamp,
    @required this.url,
    this.width,
  })  : assert(imageName != null),
        assert(size != null),
        assert(url != null),
        super(authorId, id, status, timestamp, MessageType.image);

  ImageMessage.fromPartial(
    String authorId,
    String id,
    PartialImage partialImage, {
    Status status,
    int timestamp,
  })  : this.height = partialImage.height,
        this.imageName = partialImage.imageName,
        this.size = partialImage.size,
        this.url = partialImage.url,
        this.width = partialImage.width,
        super(authorId, id, status, timestamp, MessageType.image);

  final double height;
  final String imageName;
  final int size;
  final String url;
  final double width;

  ImageMessage.fromJson(Map<String, dynamic> json)
      : height = json['height']?.toDouble(),
        imageName = json['imageName'],
        size = json['size']?.round(),
        url = json['url'],
        width = json['width']?.toDouble(),
        super(
          json['authorId'],
          json['id'],
          getStatusFromString(json['status']),
          json['timestamp'],
          MessageType.image,
        );

  Map<String, dynamic> toJson() => {
        'authorId': authorId,
        'height': height,
        'id': id,
        'imageName': imageName,
        'size': size,
        'status': status,
        'timestamp': timestamp,
        'type': 'image',
        'url': url,
        'width': width,
      };
}

/// A class that represents partial file message.
@immutable
class PartialFile {
  const PartialFile({
    @required this.fileName,
    this.mimeType,
    @required this.size,
    @required this.url,
  })  : assert(fileName != null),
        assert(size != null),
        assert(url != null);

  final String fileName;
  final String mimeType;
  final int size;
  final String url;

  PartialFile.fromJson(Map<String, dynamic> json)
      : fileName = json['fileName'],
        mimeType = json['mimeType'],
        size = json['size']?.round(),
        url = json['url'];

  Map<String, dynamic> toJson() => {
        'fileName': fileName,
        'mimeType': mimeType,
        'size': size,
        'url': url,
      };
}

/// A class that represents partial image message.
@immutable
class PartialImage {
  const PartialImage({
    this.height,
    @required this.imageName,
    @required this.size,
    @required this.url,
    this.width,
  })  : assert(imageName != null),
        assert(size != null),
        assert(url != null);

  final double height;
  final String imageName;
  final int size;
  final String url;
  final double width;

  PartialImage.fromJson(Map<String, dynamic> json)
      : height = json['height'],
        imageName = json['imageName'],
        size = json['size']?.round(),
        url = json['url'],
        width = json['width'];

  Map<String, dynamic> toJson() => {
        'height': height,
        'imageName': imageName,
        'size': size,
        'url': url,
        'width': width,
      };
}

/// A class that represents partial text message.
@immutable
class PartialText {
  const PartialText({
    @required this.text,
  }) : assert(text != null);

  final String text;

  PartialText.fromJson(Map<String, dynamic> json) : text = json['text'];

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}

/// A class that represents text message.
@immutable
class TextMessage extends Message {
  const TextMessage({
    @required String authorId,
    @required String id,
    this.previewData,
    Status status,
    @required this.text,
    int timestamp,
  })  : assert(text != null),
        super(authorId, id, status, timestamp, MessageType.text);

  TextMessage.fromPartial(
    String authorId,
    String id,
    PartialText partialText, {
    Status status,
    int timestamp,
  })  : this.previewData = null,
        this.text = partialText.text,
        super(authorId, id, status, timestamp, MessageType.text);

  final PreviewData previewData;
  final String text;

  TextMessage copyWith({
    PreviewData previewData,
  }) {
    return TextMessage(
      authorId: this.authorId,
      id: this.id,
      previewData: previewData ?? this.previewData,
      status: this.status,
      text: this.text,
      timestamp: this.timestamp,
    );
  }

  TextMessage.fromJson(Map<String, dynamic> json)
      : previewData = json['previewData'] == null
            ? null
            : PreviewData.fromJson(json['previewData']),
        text = json['text'],
        super(
          json['authorId'],
          json['id'],
          getStatusFromString(json['status']),
          json['timestamp'],
          MessageType.text,
        );

  Map<String, dynamic> toJson() => {
        'authorId': authorId,
        'id': id,
        'previewData': previewData == null ? null : previewData.toJson(),
        'status': status,
        'text': text,
        'timestamp': timestamp,
        'type': 'text',
      };
}
