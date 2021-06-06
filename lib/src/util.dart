import 'message.dart' show Status;
import 'user.dart' show Role;

/// Converts [stringStatus] to the [Status] enum.
Status? getStatusFromString(String? stringStatus) {
  for (final status in Status.values) {
    if (status.toString() == 'Status.$stringStatus') {
      return status;
    }
  }

  return null;
}

/// Converts [stringRole] to the [Role] enum.
Role? getRoleFromString(String? stringRole) {
  for (final role in Role.values) {
    if (role.toString() == 'Role.$stringRole') {
      return role;
    }
  }

  return null;
}
