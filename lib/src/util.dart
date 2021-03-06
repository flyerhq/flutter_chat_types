import 'message.dart' show Status;

/// Converts [stringStatus] to the [Status] enum.
Status? getStatusFromString(String? stringStatus) {
  for (final status in Status.values) {
    if (status.toString() == 'Status.$stringStatus') {
      return status;
    }
  }

  return null;
}
