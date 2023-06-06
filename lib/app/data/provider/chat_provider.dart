import 'dart:convert';
import 'dart:developer';

import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:movie/app/data/api/api_connect.dart';
import 'package:movie/app/utils/constants.dart';

import '../model/chat/chat_completion.dart';

class ChatProvider {
  ChatProvider();

  ApiConnect api = ApiConnect.instance;

  Future<String> completeChat({required List<Map<String, String>> message}) async {
    final body = {
      'model': "gpt-3.5-turbo",
      'messages': message,
    };

    final response = await api.post(EndPoints.chatUrl, body, headers: EndPoints.openAiHeaders);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = ChatCompletion.fromJson(response.body);
      return responseBody.choices.first.message.content.toString().trim();
    } else {
      var responseBody = jsonDecode(response.body);
      log(responseBody['error']['message'].toString());
      throw Exception('Failed to complete chat: ${response.statusCode} ${responseBody['error']['message'].toString()}');
    }
  }
}
