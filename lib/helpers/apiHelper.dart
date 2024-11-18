import 'package:appscrip/helpers/apiconst.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Apihelper {

 static Future<dynamic> getUserData() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.BASE_URL +
            ApiConstants.authEndPoints.user),
      
      );
      // print(response.body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      
      return null; // Return null or propagate the error further
    }
  }

}