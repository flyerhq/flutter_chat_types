import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../user.dart' show User;
import 'partial_audio.dart';

part 'audio_message.g.dart';

/// A class that represents image message.
@JsonSerializable()
@immutable
abstract class AudioMessage extends Message {
  /// Creates an image message.
  const AudioMessage._({
    required super.author,
    super.createdAt,
    required this.duration,
    required super.id,
    super.metadata,
    required this.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required this.size,
    super.status,
    MessageType? type,
    super.updatedAt,
    required this.uri,
    this.waveForm,
    this.mimeType,
  }) : super(type: type ?? MessageType.audio);

  const factory AudioMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    required String name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    required num size,
    Status? status,
    MessageType? type,
    int? updatedAt,
    required String uri,
    required Duration duration,
    String? mimeType,
    List<double>? waveForm,
  }) = _AudioMessage;

  /// Creates an image message from a map (decoded JSON).
  factory AudioMessage.fromJson(Map<String, dynamic> json) => _$AudioMessageFromJson(json);

  /// Creates a full image message from a partial one.
  factory AudioMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    required PartialAudio partialAudio,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    Status? status,
    int? updatedAt,
  }) =>
      _AudioMessage(
        author: author,
        createdAt: createdAt,
        duration: partialAudio.duration,
        id: id,
        metadata: partialAudio.metadata,
        name: partialAudio.name,
        remoteId: remoteId,
        repliedMessage: partialAudio.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: partialAudio.size,
        status: status,
        type: MessageType.image,
        updatedAt: updatedAt,
        uri: partialAudio.uri,
        waveForm: partialAudio.waveForm,
        mimeType: partialAudio.mimeType,
      );

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

  /// Equatable props.
  @override
  List<Object?> get props => [
        author,
        createdAt,
        mimeType,
        id,
        metadata,
        name,
        remoteId,
        repliedMessage,
        roomId,
        size,
        status,
        updatedAt,
        uri,
        waveForm,
        duration,
      ];

  @override
  Message copyWith({
    User? author,
    int? createdAt,
    double? height,
    String? id,
    Map<String, dynamic>? metadata,
    String? name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    num? size,
    Status? status,
    int? updatedAt,
    String? uri,
    double? width,
  });

  /// Converts an image message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$AudioMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _AudioMessage extends AudioMessage {
  const _AudioMessage({
    required super.author,
    super.createdAt,
    required super.duration,
    required super.id,
    super.metadata,
    required super.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required super.size,
    super.status,
    super.type,
    super.updatedAt,
    required super.uri,
    super.waveForm,
    super.mimeType,
  }) : super._();

  @override
  Message copyWith({
    User? author,
    dynamic createdAt = _Unset,
    dynamic height = _Unset,
    String? id,
    dynamic metadata = _Unset,
    dynamic duration = _Unset,
    dynamic waveForm = _Unset,
    dynamic mimeType = _Unset,
    String? name,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    num? size,
    dynamic status = _Unset,
    dynamic updatedAt = _Unset,
    String? uri,
    dynamic width = _Unset,
  }) =>
      _AudioMessage(
        author: author ?? this.author,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        duration: duration == _Unset ? this.duration : duration as Duration,
        id: id ?? this.id,
        metadata: metadata == _Unset ? this.metadata : metadata as Map<String, dynamic>?,
        name: name ?? this.name,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset ? this.repliedMessage : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus: showStatus == _Unset ? this.showStatus : showStatus as bool?,
        size: size ?? this.size,
        status: status == _Unset ? this.status : status as Status?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
        uri: uri ?? this.uri,
        waveForm: waveForm == _Unset ? this.waveForm : waveForm as List<double>?,
        mimeType: mimeType == _Unset ? this.mimeType : mimeType as String?,
      );
}

class _Unset {}
