import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';

part 'partial_audio.g.dart';

/// A class that represents partial image message.
@JsonSerializable()
@immutable
class PartialAudio {
  /// Creates a partial image message with all variables image can have.
  /// Use [ImageMessage] to create a full message.
  /// You can use [ImageMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialAudio({
    required this.duration,
    this.metadata,
    required this.name,
    this.repliedMessage,
    required this.size,
    required this.uri,
    this.waveForm,
    this.mimeType,
  });

  /// Creates a partial image message from a map (decoded JSON).
  factory PartialAudio.fromJson(Map<String, dynamic> json) => _$PartialAudioFromJson(json);

  /// The length of the audio.
  final Duration duration;

  /// Media type of the audio file.
  final String? mimeType;

  /// Wave form represented as a list of decibel level, each comprised between 0 and 120.
  final List<double>? waveForm;

  /// The audio file source (either a remote URL or a local resource).
  final String uri;

  /// The name of the audio.
  final String name;

  /// Size of the audio in bytes.
  final num size;

  /// Additional custom metadata or attributes related to the message.
  final Map<String, dynamic>? metadata;

  /// Message that is being replied to with the current message.
  final Message? repliedMessage;

  /// Converts a partial image message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$PartialAudioToJson(this);
}
