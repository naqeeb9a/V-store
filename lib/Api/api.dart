import 'package:http/http.dart' as http;

class Api {
  String baseUrl = "http://vstore.kissancorner.pk/api/v2";
  login(email, password) async {
    var res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      body: {"email": email, "password": password},
    );
    return res;
  }

  signUp(email, name, password) async {
    var res = await http.post(Uri.parse("$baseUrl/auth/signup"), body: {
      "email_or_phone": email,
      "register_by": "email",
      "name": name,
      "password": password
    });
    return res;
  }
}
