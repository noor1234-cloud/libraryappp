import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:libraryapp/models/user.dart';
import 'package:libraryapp/services/users.dart';
import 'package:libraryapp/views/update%20profile.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider.value(
        value: UserServices()
            .getAllUsers(/*FirebaseAuth.instance.currentUser!.uid*/),
        initialData: [UserModel()],
        builder: (context, child) {
          List<UserModel>userList = context.watch()<List<UserModel>>();
          return ListView.builder(itemCount: userList.length,
          itemBuilder: (context, i) {
            return Padding(
                padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                CircleAvatar(
                  radius: 80,
                ),
                SizedBox(height: 20,),
                Text("Name: ${userList[i].name}", style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Email: ${userList[i].name}", style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Phone: ${userList[i].name}", style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Address: ${userList[i].name}", style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(height: 250,),
                SizedBox(width: 30,),

                Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    UpdateprofileView(model: userList[i],)));
                  }, child: Icon(Icons.edit),),
                ],
                )


              ],
              ),
    );
  });

} ));}}