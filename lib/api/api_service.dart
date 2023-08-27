import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Login.dart';

class APIService {
  Future<Login> login(Login requestModel) async {
    var headers = {
      'Content-Type': 'application/json',
      'X-Amz-Content-Sha256': 'beaead3198f7da1e70d03ab969765e0821b24fc913697e929e726aeaebf0eba3',
      'X-Amz-Date': '20230518T180410Z',
      'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230518/us-west-2/execute-api/aws4_request, SignedHeaders=content-length;content-type;host;x-amz-content-sha256;x-amz-date, Signature=bea79a64103ac36d54e9569640416eb58e72ac02010c8ad678432fe4220abd15'
    };
    final response = await http.post(Uri.parse(
        'https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/user/login'),
        headers: headers, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return Login.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
