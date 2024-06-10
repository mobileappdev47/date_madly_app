import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ApiServiceMethodType {
  get,
  post,
}

const baseUrl = 'https://api.stripe.com/v1';
final Map<String, String> requestHeaders = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization': 'Bearer sk_test_51PM1MuBjDzSDuEdDeVdcvufEdF2mofyFz026qT9cRi7H4kRZvM5nJfvf8OWNqRXt0DpeQrZp9xNIpcJcmWDT81wx00aGBkX3rU',
};

Future<Map<String, dynamic>?> apiService({
  required ApiServiceMethodType requestMethod,
  required String endpoint,
  Map<String, dynamic>? requestBody,
}) async {
  final requestUrl = '$baseUrl/$endpoint';

  // +++++++++++++++++
  // ++ GET REQUEST ++
  // +++++++++++++++++

  if (requestMethod == ApiServiceMethodType.get) {
    try {
      final requestResponse = await http.get(
        Uri.parse(requestUrl),
        headers: requestHeaders,
      );

      return json.decode(requestResponse.body);
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  // ++++++++++++++++++
  // ++ POST REQUEST ++
  // ++++++++++++++++++

  try {
    final requestResponse = await http.post(
      Uri.parse(requestUrl),
      headers: requestHeaders,
      body: requestBody,
    );

    return json.decode(requestResponse.body);
  } catch (err) {
    debugPrint("Error: $err");
  }
  return null;
}
