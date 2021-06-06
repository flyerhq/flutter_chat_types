import 'package:flutter_chat_types/flutter_chat_types.dart'
    show TextMessage, User;

void main() {
  const user = User(id: 'authorId');
  const message = TextMessage(author: user, id: 'id', text: 'text');
  print(message.toJson());
  final json = {
    'author': {'id': 'authorId'},
    'id': 'id',
    'text': 'text'
  };
  print(TextMessage.fromJson(json).toJson());
}
