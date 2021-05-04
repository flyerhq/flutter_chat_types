import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// A class that represents user.
@immutable
class User extends Equatable {
  /// Creates a user.
  const User({
    this.avatarUrl,
    this.firstName,
    required this.id,
    this.lastName,
    this.metadata,
  });

  /// Creates a copy of the user with an updated data.
  /// [avatarUrl], [firstName] and [lastName] with null values
  /// will nullify existing values.
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  User copyWith({
    String? avatarUrl,
    String? firstName,
    String? lastName,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      avatarUrl: avatarUrl,
      firstName: firstName,
      id: id,
      lastName: lastName,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [avatarUrl, firstName, id, lastName, metadata];

  /// Remote image URL representing user's avatar
  final String? avatarUrl;

  /// First name of the user
  final String? firstName;

  /// Unique ID of the user
  final String id;

  /// Last name of the user
  final String? lastName;

  /// Additional custom metadata or attributes related to the user
  final Map<String, dynamic>? metadata;
}
