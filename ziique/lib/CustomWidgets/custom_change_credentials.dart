import 'package:flutter/material.dart';
import 'package:ziique/models/fire_user.dart';
import '../FireService/fire_auth_service.dart';

class CustomCredentialsChange extends StatefulWidget {
  const CustomCredentialsChange(
      {super.key,
      required this.emailOrPassword,
      });

  final String emailOrPassword;

  @override
  State<CustomCredentialsChange> createState() => _CustomCredentialsChangeState();
}

class _CustomCredentialsChangeState extends State<CustomCredentialsChange> {
  TextEditingController firstTextFieldController = TextEditingController();
  TextEditingController secondTextFieldController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text("Change ${widget.emailOrPassword}:", style: const TextStyle(fontSize: 24, color: Colors.white),),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 190,
            child: TextFormField(
              controller: firstTextFieldController,
              style: const TextStyle(color: Colors.white),
              obscureText: true, 
              decoration: InputDecoration(
                hintText: "New ${widget.emailOrPassword}",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent),), 
                    labelStyle: const TextStyle(
                      color: Colors.white), 
                      hintStyle: const TextStyle(
                        color: Colors.white)),)),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 190,
            child: TextFormField(
              controller: secondTextFieldController,
              style: const TextStyle(color: Colors.white),
              obscureText: true, 
              decoration: InputDecoration(
                hintText: "Confirm New ${widget.emailOrPassword}",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent),), 
                    labelStyle: const TextStyle(
                      color: Colors.white), 
                      hintStyle: const TextStyle(
                        color: Colors.white)),)),
        OutlinedButton(
          onPressed: (){
            try{
              if (widget.emailOrPassword == 'Email' && firstTextFieldController == secondTextFieldController){
                ChangeCredentialsService().changeEmail(firstTextFieldController.text);
              }else if (widget.emailOrPassword == 'Password' && firstTextFieldController == secondTextFieldController){
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
                            const Text("Please reauthenticate yourself by signing in using you old credentials"),
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
                            
                            AuthService().reauthenticate(credential);
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
                  const SnackBar(content: Text("Email is invalid"));
                  break;
                case "email-already-in-use":
                  const SnackBar(content: Text("Email is already in use"));
                  break;
                case "weak-password":
                  const SnackBar(content: Text("Password is too weak"));
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
