import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ziique/BeatBoard/beat_board-Widget.dart';
import 'package:ziique/FireService/fire_auth_service.dart';
import 'package:ziique/FireService/fire_user_service.dart';

class CreateDesktop extends StatefulWidget {
  CreateDesktop(BuildContext context);

  @override
  State<CreateDesktop> createState() => _CreateDesktopState();
}

class _CreateDesktopState extends State<CreateDesktop> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController eMailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confrimPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

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
                              setState(() {
                                isLoading = true;
                              });
                              Functions().validateAndSumbit(
                                eMailController.text,
                                passwordController.text,
                                firstNameController.text,
                                lastNameController.text,
                                context);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BeatBoardDesktop(context)));
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
  Future<void> validateAndSumbit(email, password, firstName, lastName, context) async{

    await SignUpService().SignUpWithEmailAndPassword(email, password);
    await SignInService().SignInWithEmailAndPassword(email, password);
    await UserService().CreateUser(FirebaseAuth.instance.currentUser, firstName, lastName);
  }
}

class CreateMobile extends StatefulWidget {
  CreateMobile(BuildContext context);

  @override
  State<CreateMobile> createState() => _CreateMobileState();
}

class _CreateMobileState extends State<CreateMobile> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController eMailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confrimPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12, alignment: Alignment.topCenter,
          ),
          const SizedBox(
              width: 100
          ),
        ],
      ), backgroundColor: Color.fromARGB(255, 44, 41, 41),),
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
                isLoading ? CircularProgressIndicator() :
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
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
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Functions().validateAndSumbit(
                                        eMailController.text,
                                        passwordController.text,
                                        firstNameController.text,
                                        lastNameController.text,
                                        context);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BeatBoardDesktop(context)));
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
