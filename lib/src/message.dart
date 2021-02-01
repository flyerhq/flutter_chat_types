import 'package:meta/meta.dart';
import 'package:flutter_chat_types/src/preview_data.dart' show PreviewData;
import 'package:flutter_chat_types/src/util.dart';

enum MessageType {
  file,
  image,
  text,
}

enum Status { error, read, sending, sent }

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

  final PreviewData previewData;
  final String text;

  TextMessage.fromJson(Map<String, dynamic> json)
      : previewData = json['previewData'],
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
        'previewData': previewData,
        'status': status,
        'text': text,
        'timestamp': timestamp,
        'type': 'text',
      };
}
