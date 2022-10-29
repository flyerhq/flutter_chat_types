import 'package:flutter_chat_types/flutter_chat_types.dart' show TextMessage, AudioMessage, PartialAudio, User;

void main() {
  const user = User(id: 'authorId');
  const message = TextMessage(author: user, id: 'id', text: 'text');
  // ignore: avoid_print
  print(message.toJson());
  final json = {
    'author': {'id': 'authorId'},
    'id': 'id',
    'text': 'text',
  };
  // ignore: avoid_print
  print(TextMessage.fromJson(json).toJson());
  _audioMessageTest();
  _audioMessagePartialTest();
}

void _audioMessageTest() {
  const user = User(id: 'authorId');
  const message = AudioMessage(
    name: 'myAudio',
    author: user,
    id: 'id',
    size: 100,
    uri: 'https://myaudio.com',
    duration: Duration(seconds: 5),
  );
  // ignore: avoid_print
  print(message.toJson());
  final json = {
    'author': {'id': 'authorId'},
    'id': 'id',
    'name': 'myAudio',
    'uri': 'https://myaudio.com',
    'size': 100,
    'length': 5000000,
  };
  // ignore: avoid_print
  print(AudioMessage.fromJson(json).toJson());
}

void _audioMessagePartialTest() {
  const user = User(id: 'authorId');
  final json = {
    'author': {'id': 'authorId'},
    'id': 'id',
    'length': 5000000,
    'uri': 'https://myaudio.com',
    'size': 100,
    'name': 'myAudio',
  };
  final partial = PartialAudio.fromJson(json);
  final message = AudioMessage.fromPartial(
    author: user,
    partialAudio: partial,
    id: 'id',
  );
  // ignore: avoid_print
  print(message.toJson());

  // ignore: avoid_print
  print(AudioMessage.fromJson(json).toJson());
}
