import 'package:appscrip/controllers/userController.dart';
import 'package:appscrip/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Usercontroller usercontroller = Get.put(Usercontroller());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppScrip'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search TextField
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, email, or phone',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                usercontroller.searchQuery.value = value; // Update the search query
              },
            ),
            const SizedBox(height: 10),

            // User List
            Expanded(
              child: Obx(() {
                return usercontroller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: usercontroller.filteredUsers.length,
                        itemBuilder: (context, index) {
                          var user = usercontroller.filteredUsers[index];
                          return Material(
                            elevation: 3,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: SvgPicture.asset(
                                        'assets/icons/female.svg',
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(user.name!),
                                        Text(user.email!),
                                        Text(user.phone!),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: IconButton(
                                      onPressed: () {
                                        Get.to(() => ProfilePage(user: user));
                                      },
                                      icon: const Icon(Icons.arrow_forward_ios),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
