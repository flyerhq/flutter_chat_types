import 'package:meta/meta.dart';
import 'image_message.dart';

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
