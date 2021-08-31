// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomMessage _$CustomMessageFromJson(Map<String, dynamic> json) =>
    CustomMessage(
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int?,
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      roomId: json['roomId'] as String?,
      status: _$enumDecodeNullable(_$StatusEnumMap, json['status']),
      type: _$enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$CustomMessageToJson(CustomMessage instance) =>
    <String, dynamic>{
      'author': instance.author.toJson(),
      'createdAt': instance.createdAt,
      'id': instance.id,
      'metadata': instance.metadata,
      'roomId': instance.roomId,
      'status': _$StatusEnumMap[instance.status],
      'type': _$MessageTypeEnumMap[instance.type],
      'updatedAt': instance.updatedAt,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$StatusEnumMap = {
  Status.delivered: 'delivered',
  Status.error: 'error',
  Status.seen: 'seen',
  Status.sending: 'sending',
  Status.sent: 'sent',
};

const _$MessageTypeEnumMap = {
  MessageType.custom: 'custom',
  MessageType.file: 'file',
  MessageType.image: 'image',
  MessageType.text: 'text',
  MessageType.unsupported: 'unsupported',
};
