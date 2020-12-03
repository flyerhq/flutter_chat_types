import 'package:flutter_chat_types/src/message.dart';

Status getStatusFromString(String stringStatus) {
  for (Status status in Status.values) {
    if (status.toString() == 'Status.$stringStatus') {
      return status;
    }
  }

  return null;
}
