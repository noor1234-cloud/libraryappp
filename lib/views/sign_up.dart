import 'package:flutter/material.dart';
import 'package:libraryapp/models/user.dart';
import 'package:libraryapp/services/users.dart';
import 'package:libraryapp/views/profile.dart';
import 'package:libraryapp/views/update%20profile.dart';
import '../services/auth.dart';

class RegisterView extends StatefulWidget {
@override
State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController addressController = TextEditingController();
bool isLoading = false;

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: Padding(
padding: const EdgeInsets.symmetric(horizontal: 30.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
// Register Title
Align(
alignment: Alignment.centerLeft,
child: Text(
'Sign Up',
style: TextStyle(
fontSize: 32,
fontWeight: FontWeight.bold,
),
),
),
SizedBox(height: 40),

// Full Name Field
Align(
alignment: Alignment.centerLeft,
child: Text(
'NAME',
style: TextStyle(
fontSize: 10,
fontWeight: FontWeight.bold,
color: Colors.grey[700],
letterSpacing: 0.5,
),
),
),
SizedBox(height: 5),
TextField(
controller: nameController,
decoration: InputDecoration(
hintText: 'Enter your full name',
filled: true,
fillColor: Color(0xFFF1F3F4),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
borderSide: BorderSide.none,
),
),
),
SizedBox(height: 20),

// Email Field
Align(
alignment: Alignment.centerLeft,
child: Text(
'EMAIL',
style: TextStyle(
fontSize: 10,
fontWeight: FontWeight.bold,
color: Colors.grey[700],
letterSpacing: 0.5,
),
),
),
SizedBox(height: 5),
TextField(
controller: emailController,
decoration: InputDecoration(
hintText: 'abc123@example.com',
filled: true,
fillColor: Color(0xFFF1F3F4),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
borderSide: BorderSide.none,
),
),
),
SizedBox(height: 20),

// Password Field
Align(
alignment: Alignment.centerLeft,
child: Text(
'PASSWORD',
style: TextStyle(
fontSize: 10,
fontWeight: FontWeight.bold,
color: Colors.grey[700],
letterSpacing: 0.5,
),
),
),
SizedBox(height: 5),
TextField(
controller: passwordController,
obscureText: true,
decoration: InputDecoration(
filled: true,
fillColor: Color(0xFFF1F3F4),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
borderSide: BorderSide.none,
),
),
),
SizedBox(height: 20),

// Address Field
Align(
alignment: Alignment.centerLeft,
child: Text(
'ADDRESS',
style: TextStyle(
fontSize: 10,
fontWeight: FontWeight.bold,
color: Colors.grey[700],
letterSpacing: 0.5,
),
),
),
SizedBox(height: 5),
TextField(
controller: addressController,
decoration: InputDecoration(
hintText: 'Enter your address',
filled: true,
fillColor: Color(0xFFF1F3F4),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
borderSide: BorderSide.none,
),
),
),
SizedBox(height: 20),

// Phone Number Field
Align(
alignment: Alignment.centerLeft,
child: Text(
'PHONE NUMBER',
style: TextStyle(
fontSize: 10,
fontWeight: FontWeight.bold,
color: Colors.grey[700],
letterSpacing: 0.5,
),
),
),
SizedBox(height: 5),
TextField(
controller: phoneController,
decoration: InputDecoration(
hintText: 'Enter your phone number',
filled: true,
fillColor: Color(0xFFF1F3F4),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
borderSide: BorderSide.none,
),
),
),
SizedBox(height: 40),

// Sign Up Button
isLoading
? Center(child: CircularProgressIndicator())
    : SizedBox(
width: double.infinity,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.pink,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(30),
),
padding: EdgeInsets.symmetric(vertical: 15),
),
  onPressed: () async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email cannot be empty")),
      );
      return;
    }
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password cannot be empty")),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await AuthServices()
          .signUpUser(
          email: emailController.text, password: passwordController.text)
          .then((val) async {
        UserModel newUser = UserModel(
          docId: val!.uid,
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          address: addressController.text,
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        await UserServices().createUser(newUser);

        setState(() {
          isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>UpdateprofileView(),

          ),
        );

      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  },

child: Text(
'Sign Up',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
),
),

SizedBox(height: 40),

// Back to Login
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: Text(
"Back to Login",
style: TextStyle(
fontSize: 14,
color: Colors.pink,
),
),
),
],
),
),
);
}
}
