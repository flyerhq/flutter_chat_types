import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import 'partial_text.dart';

part 'text_message.g.dart';

/// The language ISO codes for all supported languages.
enum ISOCode {
  /// The ISOCode for Germany.
  de,

  /// The ISOCode for English.
  en,

  /// The ISOCode for Ukraine.
  uk,

  /// The ISOCode for Turkey.
  tr,

  /// The ISOCode for Russia.
  ru,

  /// The ISOCode for Poland.
  pl,

  /// The Orginal Langauge
  og;

  @override
  String toString() {
    const isoCodeToString = <ISOCode, String>{
      ISOCode.de: 'Deutsch',
      ISOCode.en: 'English',
      ISOCode.uk: 'Українська',
      ISOCode.tr: 'Türkçe',
      ISOCode.ru: 'Русский',
      ISOCode.pl: 'Polski',
      ISOCode.og: 'Original',
    };
    if (isoCodeToString.containsKey(this)) return isoCodeToString[this]!;

    throw Exception(['ISOCode.toString() failed. This should never happen.']);
  }

  /// Get the enum representation of the string.
  static ISOCode fromString(String isoCode) {
    const isoCodeMapping = <String, ISOCode>{
      'Deutsch': ISOCode.de,
      'English': ISOCode.en,
      'Українська': ISOCode.uk,
      'Türkçe': ISOCode.tr,
      'Русский': ISOCode.ru,
      'Polski': ISOCode.pl,
      'Original': ISOCode.og,
    };
    if (isoCodeMapping.containsKey(isoCode)) return isoCodeMapping[isoCode]!;

    throw Exception(['Unknown ISOCode: $isoCode']);
  }
}

/// A class that represents text message.
@JsonSerializable()
@immutable
abstract class TextMessage extends Message {
  /// Creates a text message.
  const TextMessage._({
    required super.author,
    super.createdAt,
    required super.id,
    super.metadata,
    this.previewData,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    required this.text,
    this.translations,
    MessageType? type,
    super.updatedAt,
  }) : super(type: type ?? MessageType.text);

  const factory TextMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    Status? status,
    required String text,
    Map<ISOCode, String>? translations,
    MessageType? type,
    int? updatedAt,
  }) = _TextMessage;

  /// Creates a text message from a map (decoded JSON).
  factory TextMessage.fromJson(Map<String, dynamic> json) =>
      _$TextMessageFromJson(json);

  /// Creates a full text message from a partial one.
  factory TextMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    required PartialText partialText,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    Status? status,
    int? updatedAt,
  }) =>
      _TextMessage(
        author: author,
        createdAt: createdAt,
        id: id,
        metadata: partialText.metadata,
        previewData: partialText.previewData,
        remoteId: remoteId,
        repliedMessage: partialText.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        status: status,
        text: partialText.text,
        type: MessageType.text,
        updatedAt: updatedAt,
      );

  /// See [PreviewData].
  final PreviewData? previewData;

  /// User's message.
  final String text;

  /// Translations
  final Map<ISOCode, String>? translations;

  /// Equatable props.
  List<Object?> get props => [
        author,
        createdAt,
        id,
        metadata,
        previewData,
        remoteId,
        repliedMessage,
        roomId,
        showStatus,
        status,
        text,
        updatedAt,
        translations,
      ];

  @override
  Message copyWith({
    User? author,
    int? createdAt,
    String? id,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    Status? status,
    String? text,
    int? updatedAt,
  });

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _TextMessage extends TextMessage {
  const _TextMessage({
    required super.author,
    super.createdAt,
    required super.id,
    super.metadata,
    super.previewData,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    required super.text,
    super.translations,
    super.type,
    super.updatedAt,
  }) : super._();

  @override
  Message copyWith({
    User? author,
    dynamic createdAt = _Unset,
    String? id,
    dynamic metadata = _Unset,
    dynamic previewData = _Unset,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    dynamic status = _Unset,
    String? text,
    dynamic translations = _Unset,
    dynamic updatedAt = _Unset,
  }) =>
      _TextMessage(
        author: author ?? this.author,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        id: id ?? this.id,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        previewData: previewData == _Unset
            ? this.previewData
            : previewData as PreviewData?,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        status: status == _Unset ? this.status : status as Status?,
        text: text ?? this.text,
        translations: translations == _Unset
            ? this.translations
            : translations as Map<ISOCode, String>?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
      );
}

class _Unset {}
