import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'message.dart';
import 'user.dart';
import 'util.dart';

/// All possible room types
enum RoomType { channel, direct, group, unsupported }

/// Extension with one [toShortString] method
extension RoomTypeToShortString on RoomType {
  /// Converts enum to the string equal to enum's name
  String toShortString() {
    return toString().split('.').last;
  }
}

/// A class that represents a room where 2 or more participants can chat
@immutable
class Room extends Equatable {
  /// Creates a [Room]
  const Room({
    this.createdAt,
    required this.id,
    this.imageUrl,
    this.lastMessages,
    this.metadata,
    this.name,
    required this.type,
    this.updatedAt,
    required this.users,
  });

  /// Creates room from a map (decoded JSON).
  Room.fromJson(Map<String, dynamic> json)
      : createdAt = json['createdAt'] as int?,
        id = json['id'] as String,
        imageUrl = json['imageUrl'] as String?,
        lastMessages = (json['lastMessages'] as List<Map<String, dynamic>>)
            .map((e) => Message.fromJson(e))
            .toList(),
        metadata = json['metadata'] as Map<String, dynamic>?,
        name = json['name'] as String?,
        type = getRoomTypeFromString(json['type'] as String),
        updatedAt = json['updatedAt'] as int?,
        users = (json['users'] as List<Map<String, dynamic>>)
            .map((e) => User.fromJson(e))
            .toList();

  /// Converts room to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'id': id,
        'imageUrl': imageUrl,
        'lastMessages': lastMessages?.map((e) => e.toJson()).toList(),
        'metadata': metadata,
        'name': name,
        'type': type.toShortString(),
        'updatedAt': updatedAt,
        'users': users.map((e) => e.toJson()).toList(),
      };

  /// Creates a copy of the room with an updated data.
  /// [imageUrl], [name] and [updatedAt] with null values will nullify existing values
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [type] and [users] with null values will be overwritten by previous values.
  Room copyWith({
    String? imageUrl,
    Map<String, dynamic>? metadata,
    String? name,
    RoomType? type,
    int? updatedAt,
    List<User>? users,
  }) {
    return Room(
      id: id,
      imageUrl: imageUrl,
      lastMessages: lastMessages,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      name: name,
      type: type ?? this.type,
      updatedAt: updatedAt,
      users: users ?? this.users,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        createdAt,
        id,
        imageUrl,
        lastMessages,
        metadata,
        name,
        type,
        updatedAt,
        users
      ];

  /// Created room timestamp, in ms
  final int? createdAt;

  /// Room's unique ID
  final String id;

  /// Room's image. In case of the [RoomType.direct] - avatar of the second person,
  /// otherwise a custom image [RoomType.group].
  final String? imageUrl;

  /// List of last messages this room has received
  final List<Message>? lastMessages;

  /// [RoomType]
  final RoomType type;

  /// Additional custom metadata or attributes related to the room
  final Map<String, dynamic>? metadata;

  /// Room's name. In case of the [RoomType.direct] - name of the second person,
  /// otherwise a custom name [RoomType.group].
  final String? name;

  /// Updated room timestamp, in ms
  final int? updatedAt;

  /// List of users which are in the room
  final List<User> users;
}
