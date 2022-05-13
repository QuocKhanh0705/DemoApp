import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'contact.dart';

class URLS {
  static const String BASE_URL = 'http://api.phanmemquocbao.com/api/Doituong';
}

class ApiService {
  static Future<List<Contact>> getContact() async {
    final uri = Uri.parse("${URLS.BASE_URL}/getobjectsall");
    final Map<String, String> queryParams = {"tokenget": "lethibaotran"};
    final uriQuery = uri.replace(queryParameters: queryParams);

    final response = await http.get(uriQuery);
    print(response.body);
    if (response.statusCode == 200) {
      return compute(parseContact, response.body);
    } else {
      return List.empty();
    }
  }

  static Future<bool> addContact(queryParams) async {
    final uri = Uri.parse("${URLS.BASE_URL}/InsertObjects");
    final uriQuery = uri.replace(queryParameters: queryParams);

    final response = await http.get(uriQuery);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  static Future<bool> updateContact(queryParams) async {
    final uri = Uri.parse("${URLS.BASE_URL}/updateObjects");
    final uriQuery = uri.replace(queryParameters: queryParams);

    final response = await http.get(uriQuery);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteContact(id) async {
    final uri = Uri.parse("${URLS.BASE_URL}/deleteObject");
    final Map<String, String> queryParams = {
      "id": id.toString(),
      "tokende": "lethibaotran"
    };
    final uriQuery = uri.replace(queryParameters: queryParams);

    final response = await http.get(uriQuery);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static List<Contact> parseContact(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
  }
}
