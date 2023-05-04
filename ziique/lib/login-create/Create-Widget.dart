import 'package:flutter/material.dart';
import 'package:ziique/FireService/Fire_AuthService.dart';

bool isLoading = false;

class CreateDesktop extends StatelessWidget {
  CreateDesktop(BuildContext context);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confrimPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/blue-background.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset("assets/images/ZiiQue-Logo.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading ? CircularProgressIndicator() :
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 400,
                          child: TextFormField(
                            controller: firstNameController,
                            decoration: InputDecoration(hintText: "First Name"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 400,
                          child: TextFormField(
                            controller: lastNameController,
                            decoration: InputDecoration(hintText: "Last Name"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 400,
                          child: TextFormField(
                            controller: eMailController,
                            decoration: InputDecoration(hintText: "Email"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 400,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(hintText: "Password"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 400,
                          child: TextFormField(
                            controller: confrimPasswordController,
                            obscureText: true,
                            decoration:
                                InputDecoration(hintText: "Confirm Password"),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 230,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 217, 217, 217)),
                            onPressed: () {
                              Functions().validateAndSumbit(eMailController.text, passwordController.text);
                            },
                            child: Text(
                              "Create Account",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          )),
    );
  }
}

class Functions{
  Future<void> validateAndSumbit(email, password) async{
    isLoading = true;
    await SignUpService().SignUpWithEmailAndPassword(email, password);
    isLoading = false;
  }
}

class CreateMobile extends StatelessWidget {
  CreateMobile(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/blue-background.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Container(
            child: Column(
              children: [
                Container(),
                Container(),
              ],
            ),
          )),
    );
  }
}
