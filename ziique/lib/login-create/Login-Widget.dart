import 'package:flutter/material.dart';
import 'package:ziique/FireService/Fire_Login-Create.dart';

class LoginDesktop extends StatelessWidget {
  LoginDesktop(BuildContext context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/blue-background.png"),
              fit: BoxFit.none,
            )
        ),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 250,
                child: Image.asset("assets/images/Ziique-logo.png"),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      SizedBox(
                        width: 400,
                          child: TextFormField(controller: emailController,decoration: InputDecoration(hintText: "Email"),)),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 400,
                          child: TextFormField(controller: passwordController ,obscureText: true, decoration: InputDecoration(hintText: "Password"),)),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 200,
                          height: 40,
                          child: ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 217, 217, 217)),onPressed: (){SignInService().SignInWithEmailAndPassword(emailController.text, passwordController.text);}, child: Text("Log In", style: TextStyle(fontSize: 24, color: Colors.black),))
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}

class LoginMobile extends StatelessWidget {
  LoginMobile(BuildContext context);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blue-background.png"),
            fit: BoxFit.none,
          )
        ),
        child: Container(
          child: Column(
            children: [
              Container(),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
