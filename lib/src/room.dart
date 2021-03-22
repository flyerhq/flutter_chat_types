import 'package:meta/meta.dart';
import 'user.dart';

/// All possible room types
enum RoomType { direct, group }

/// A class that represents a room where 2 or more participants can chat
@immutable
class Room {
  /// Creates a [Room]
  const Room({
    required this.id,
    this.imageUrl,
    this.name,
    required this.type,
    required this.users,
  });

  /// Room's unique ID
  final String id;

  /// Room's image. In case of the [RoomType.direct] - avatar of the second person,
  /// otherwise a custom image [RoomType.group].
  final String? imageUrl;

  /// Type of the room, direct, group etc.
  final RoomType type;

  /// Room's name. In case of the [RoomType.direct] - name of the second person,
  /// otherwise a custom name [RoomType.group].
  final String? name;

  /// List of users which are in the room
  final List<User> users;
}
