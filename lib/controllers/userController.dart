import 'dart:convert';

import 'package:appscrip/helpers/apiHelper.dart';
import 'package:appscrip/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Usercontroller extends GetxController {
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      final response = await Apihelper.getUserData();
      if (response != null && response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var item in data) {
          users.add(UserModel.fromJson(item));
        }
      }
      else{
        Get.snackbar('Error', "SERVER ERROR : ${response.statusCode}" ,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
      }
    } catch (e) {
      print(e.toString());
        Get.snackbar('Error', "SERVER ERROR" ,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
    }
    finally {
      isLoading.value = false;
    }
    // final response = await Apihelper.getUserData();
    // if (response != null) {
    //   final List<UserModel> userList = userModelFromJson(response.body);
    //   users.assignAll(userList);
    // }
  }
}
