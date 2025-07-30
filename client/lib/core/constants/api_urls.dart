class ApiUrls {
  static const baseURL = 'http://192.168.1.15:3000';
  static const registerURL = '$baseURL/api/auth/register';
  static const userProfileURL = '$baseURL/api/auth/profile';
  static const loginURL = '$baseURL/api/auth/login';
  static const forgetPassURL = '$baseURL/api/auth/forget-password';
  static const resetPassURL = '$baseURL/api/auth/forget-password';
  static const verifyOtpURL = '$baseURL/api/auth/verify';

  static const messagesURL = '$baseURL/api/message/:id';
  static const chatroomURL = '$baseURL/api/chatbot/rooms';
  static const createRoomsURL = '$baseURL/api/chatbot/create';
  static const renameRoomURL = '$baseURL/api/chatbot/rename';
  static const scanURL = '$baseURL/api/scan/upload';
  static const ChatbotIdURL = '$baseURL/api/message/:chatbotId';

  static const testURL = 'https://fermion.free.beeceptor.com';
  static const testURL2 = 'https://webhook.site/4e8cb70b-7535-4ff5-9d5e-9a89f1afa4df';
  static const testURL3 = 'https://68850680745306380a3a226c.mockapi.io/api/v1/';

  /* static const usersURL2 = '$baseURL/users';
  static const registerURL = '$baseURL/register';
  static const userProfileURL = '$baseURL/profile';
  static const loginURL = '$baseURL/users';
  static const forgetPassURL = '$baseURL/forget-password';
  static const resetPassURL = '$baseURL/forget-password'; */

}