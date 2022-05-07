import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> sendReview(String userMessage) async {
  return http.post(Uri.parse('http://157.230.97.33:9090/reviews'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'text': userMessage}));
}

Future<http.Response> subscribeToPromotions(String name, String email, String number, String message) {
  return http.post(Uri.parse('http://192.168.0.105:1337/feedbacks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': name, 'email': email, 'number': number,'message': message}));
}
