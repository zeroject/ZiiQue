import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziique/models/fire_user.dart';

import '../FireService/fire_auth_service.dart';

class CustomCredentialsChange extends StatefulWidget {
  const CustomCredentialsChange(
      {super.key,
      required this.editEmail,
      required this.editPassword,
      });

  final bool editEmail;
  final bool editPassword;

  @override
  State<CustomCredentialsChange> createState() => _CustomCredentialsChangeState();
}

class _CustomCredentialsChangeState extends State<CustomCredentialsChange> {
  bool isReadOnly = true;
  TextEditingController firstTextFieldController = TextEditingController();
  TextEditingController secondTextFieldController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Change Password', style: TextStyle(fontSize: 24, color: Colors.white),),
        OutlinedButton(
          onPressed: (){
            setState(() {
              isReadOnly = false;
            });
          },
          child: const Text("Edit")
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 190,
            child: TextFormField(
              readOnly: isReadOnly,
              controller: firstTextFieldController,
              style: const TextStyle(color: Colors.white),
              obscureText: true, 
              decoration: const InputDecoration(
                hintText: "New Password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent),), 
                    labelStyle: TextStyle(
                      color: Colors.white), 
                      hintStyle: TextStyle(
                        color: Colors.white)),)),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 190,
            child: TextFormField(
              readOnly: isReadOnly,
              controller: secondTextFieldController,
              style: const TextStyle(color: Colors.white),
              obscureText: true, 
              decoration: const InputDecoration(
                hintText: "Confirm New Password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent),), 
                    labelStyle: TextStyle(
                      color: Colors.white), 
                      hintStyle: TextStyle(
                        color: Colors.white)),)),
        OutlinedButton(
          onPressed: (){
            try{
              if (widget.editEmail && firstTextFieldController == secondTextFieldController){
                ChangeCredentialsService().changeEmail(firstTextFieldController.text);
              }else if (widget.editPassword && firstTextFieldController == secondTextFieldController){
                ChangeCredentialsService().changePassword(firstTextFieldController.text);
              }
            }on FirebaseAuthException catch(e){
              switch(e.code){
                case "requires-recent-login":
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: const Text("Re Login"),
                      content: SizedBox(
                        height: 150,
                        width: 300,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text("Please reauthenticate yourself by signing in using you old credentials"),
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(hintText: "Email"),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(hintText: "Password"),
                            ),
                            ],
                          ),
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: (){
                            AuthCredential credential = EmailAuthProvider
                            .credential(email: emailController.text, password: passwordController.text);

                            ChangeCredentialsService().changePassword(firstTextFieldController.text);
                          },
                          child: const Text("Cancel")),
                        OutlinedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text("Ok")),
                      ],
                    ));
                  break;
                case "invalid-email":
                  SnackBar(content: Text("Email is invalid"));
                  break;
                case "email-already-in-use":
                  SnackBar(content: Text("Email is already in use"));
                  break;
                case "weak-password":
                  SnackBar(content: Text("Password is too weak"));
                  break;
              }
            }
          },
          child: const Text("Apply Changes")
        ), 
      ],
    );
  }
}
