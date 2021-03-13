import 'package:meta/meta.dart';
import 'user.dart';

/// A class that represents a room where 2 or more participants can chat
@immutable
class Room {
  /// Creates a [Room]
  const Room({
    required this.id,
    this.imageUrl,
    required this.isGroup,
    this.name,
    required this.users,
  });

  /// Room's unique ID
  final String id;

  /// Room's image. In case the room has 2 users - avatar of the second person,
  /// otherwise custom image (for a group).
  final String? imageUrl;

  /// Should be true if more than 2 users are in the room
  final bool isGroup;

  /// Room's name. In case the room has 2 users - name of the second person,
  /// otherwise custom name (for a group).
  final String? name;

  /// List of users which are in the room
  final List<User> users;
}
