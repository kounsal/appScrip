import 'package:appscrip/controllers/userController.dart';
import 'package:appscrip/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Usercontroller usercontroller = Get.put(Usercontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppScrip'),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx((){
          return usercontroller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: usercontroller.users.length,
            itemBuilder: (context, index) {
              return Material(
                elevation: 60,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(22),
                  
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Expanded(flex: 4 , child:  CircleAvatar(
                        radius: 30,
                       
                        child: SvgPicture.asset('assets/icons/female.svg' , height: 60, width: 60),
                      )),
                  
                      Expanded(
                        flex: 9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(usercontroller.users[index].name!),
                            Text(usercontroller.users[index].email!),
                            Text(usercontroller.users[index].phone!),
                          ],
                        ),
                      ),
                      Expanded(flex: 2, child: IconButton(onPressed: (){
                        Get.to(()=> ProfilePage(user: usercontroller.users[index],));
                      }, icon: const Icon(Icons.arrow_forward_ios),),)
                    
                    ],
                  )
                ),
              );
            },
          );
        }),
      )
    );
  }
}