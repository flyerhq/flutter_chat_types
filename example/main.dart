import 'package:flutter_chat_types/flutter_chat_types.dart' show TextMessage;

void main() {
  const message = TextMessage(authorId: 'authorId', id: 'id', text: 'text');
  print(message.toJson());
  final json = {'authorId': 'authorId', 'id': 'id', 'text': 'text'};
  print(TextMessage.fromJson(json).toJson());
}
