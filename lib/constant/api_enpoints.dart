// import 'dart:io';

class ApiEnpoints {
  final String BaseUrl = "https://mjt0lpqp-5555.usw3.devtunnels.ms/";
  // ignore: non_constant_identifier_names
  // final String BaseUrl = "http://localhost:5555/";
  final headers = {
    'Accept': 'application/json',
  };
  // final String BaseUrl = "https://sparkapi.mihirdaka.tech/";

  final String registerUser = "auth/register";
  final String loginUser = "auth/login";
  final String checkUserNameAvailibility = "user/checkUserNameAvailability";
  final String checkExistingEmail = "user/checkEmailForSignup";

  final String chat = "chat/text";
  final String talk = "chat/talk";
}
