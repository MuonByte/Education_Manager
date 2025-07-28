import 'dart:io';

class ChatRoomModel {
  final bool newRoom;
  final String roomName;
  final String roomId;

  ChatRoomModel({
    required this.newRoom,
    required this.roomName,
    required this.roomId,
  });
}

class MessageModel {
  final String messageId;
  final String messageText;

  MessageModel({
    required this.messageId,
    required this.messageText,
  });
}

class CreateChatRoomParams {
  final String roomName;

  CreateChatRoomParams({required this.roomName});

  Map<String, dynamic> toMap() => {"roomName": roomName};
}

class FetchChatRoomsParams {}

class SendMessageParams {
  final String roomId;
  final String messageText;
  final File? imageFile;

  SendMessageParams({
    required this.roomId,
    required this.messageText,
    this.imageFile,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': messageText,
    };
  }
}

class FetchMessagesParams {
  final String roomId;

  FetchMessagesParams({required this.roomId});

  Map<String, dynamic> toMap() => {"roomId": roomId};
}

class DeleteChatRoomParams {
  final String roomId;

  DeleteChatRoomParams({required this.roomId});

  Map<String, dynamic> toMap() => {"roomId": roomId};
}