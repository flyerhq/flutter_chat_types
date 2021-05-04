import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'user.dart';

/// All possible room types
enum RoomType { direct, group }

/// A class that represents a room where 2 or more participants can chat
@immutable
class Room extends Equatable {
  /// Creates a [Room]
  const Room({
    required this.id,
    this.imageUrl,
    this.metadata,
    this.name,
    required this.type,
    required this.users,
  });

  /// Creates a copy of the room with an updated data.
  /// [imageUrl] and [name] with null values will nullify existing values
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [type] and [users] with null values will be overwritten by previous values.
  Room copyWith({
    String? imageUrl,
    Map<String, dynamic>? metadata,
    String? name,
    RoomType? type,
    List<User>? users,
  }) {
    return Room(
      id: id,
      imageUrl: imageUrl,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      name: name,
      type: type ?? this.type,
      users: users ?? this.users,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [id, imageUrl, metadata, name, type, users];

  /// Room's unique ID
  final String id;

  /// Room's image. In case of the [RoomType.direct] - avatar of the second person,
  /// otherwise a custom image [RoomType.group].
  final String? imageUrl;

  /// Type of the room, direct, group etc.
  final RoomType type;

  /// Additional custom metadata or attributes related to the room
  final Map<String, dynamic>? metadata;

  /// Room's name. In case of the [RoomType.direct] - name of the second person,
  /// otherwise a custom name [RoomType.group].
  final String? name;

  /// List of users which are in the room
  final List<User> users;
}
