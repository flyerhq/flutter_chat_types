import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    this.avatarUrl,
    @required this.firstName,
    @required this.id,
    @required this.lastName,
  })  : assert(firstName != null),
        assert(id != null),
        assert(lastName != null);

  final String avatarUrl;
  final String firstName;
  final String id;
  final String lastName;
}
