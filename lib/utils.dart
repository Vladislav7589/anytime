import 'dart:convert';
import 'dart:ffi';
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

Future<http.Response> newOrders (String name, String json, String email, String ready , bool takeout, int total) {
  return http.post(Uri.parse('http://192.168.0.105:1337/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'place': name, 'order': json, 'email': email, 'status': ready, 'takeout': takeout, 'total': total}));
}

Future<http.Response> getCustomers(){
  return http.get(Uri.parse('http://192.168.0.105:1337/customers'));
}