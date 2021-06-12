import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'util.dart' show getRoleFromString;

/// All possible roles user can have.
enum Role { admin, agent, moderator, user }

/// Extension with one [toShortString] method
extension RoleToShortString on Role {
  /// Converts enum to the string equal to enum's name
  String toShortString() {
    return toString().split('.').last;
  }
}

/// A class that represents user.
@immutable
class User extends Equatable {
  /// Creates a user.
  const User({
    this.createdAt,
    this.firstName,
    required this.id,
    this.imageUrl,
    this.lastName,
    this.lastSeen,
    this.metadata,
    this.role,
  });

  /// Creates user from a map (decoded JSON).
  User.fromJson(Map<String, dynamic> json)
      : createdAt = json['createdAt'] as int?,
        firstName = json['firstName'] as String?,
        id = json['id'] as String,
        imageUrl = json['imageUrl'] as String?,
        lastName = json['lastName'] as String?,
        lastSeen = json['lastSeen'] as int?,
        metadata = json['metadata'] as Map<String, dynamic>?,
        role = getRoleFromString(json['role'] as String?);

  /// Converts user to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'firstName': firstName,
        'id': id,
        'imageUrl': imageUrl,
        'lastName': lastName,
        'lastSeen': lastSeen,
        'metadata': metadata,
        'role': role?.toShortString(),
      };

  /// Creates a copy of the user with an updated data.
  /// [firstName], [imageUrl], [lastName], [lastSeen] and [role] with
  /// null values will nullify existing values.
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  User copyWith({
    String? firstName,
    String? imageUrl,
    String? lastName,
    int? lastSeen,
    Map<String, dynamic>? metadata,
    Role? role,
  }) {
    return User(
      firstName: firstName,
      id: id,
      imageUrl: imageUrl,
      lastName: lastName,
      lastSeen: lastSeen,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      role: role,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props =>
      [createdAt, firstName, id, imageUrl, lastName, lastSeen, metadata, role];

  /// Created user timestamp, in ms
  final int? createdAt;

  /// First name of the user
  final String? firstName;

  /// Unique ID of the user
  final String id;

  /// Remote image URL representing user's avatar
  final String? imageUrl;

  /// Last name of the user
  final String? lastName;

  /// Timestamp when user was last visible, in ms
  final int? lastSeen;

  /// Additional custom metadata or attributes related to the user
  final Map<String, dynamic>? metadata;

  /// User [Role]
  final Role? role;
}
