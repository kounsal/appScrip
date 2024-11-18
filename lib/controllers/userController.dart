import 'dart:convert';
import 'package:appscrip/helpers/apiHelper.dart';
import 'package:appscrip/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Usercontroller extends GetxController {
  RxList<UserModel> users = <UserModel>[].obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs; 
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    searchQuery.listen((query) {
      filterUsers(query);
    });
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
          filteredUsers.assignAll(users);
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
  }

  // Method to filter users based on the search query
  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      filteredUsers.assignAll(users.where((user) {
        return user.name!.toLowerCase().contains(query.toLowerCase()) ||
            user.email!.toLowerCase().contains(query.toLowerCase()) ||
            user.phone!.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }
}
