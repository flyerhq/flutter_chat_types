import 'package:meta/meta.dart';
import 'file_message.dart';

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
