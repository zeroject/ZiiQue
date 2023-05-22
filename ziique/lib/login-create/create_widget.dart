import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ziique/BeatBoard/beat_board_widget.dart';
import 'package:ziique/FireService/fire_auth_service.dart';
import 'package:ziique/FireService/fire_user_service.dart';

class CreateDesktop extends StatefulWidget {
  const CreateDesktop(BuildContext context, {super.key});

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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("../assets/images/Ziique_back.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  '../assets/images/ZiiQue-Logo.png',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 400,
                              child: TextFormField(
                                controller: firstNameController,
                                decoration: const InputDecoration(
                                    hintText: "First Name"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 400,
                              child: TextFormField(
                                controller: lastNameController,
                                decoration: const InputDecoration(
                                    hintText: "Last Name"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 400,
                              child: TextFormField(
                                controller: eMailController,
                                decoration:
                                    const InputDecoration(hintText: "Email"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 400,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration:
                                    const InputDecoration(hintText: "Password"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 400,
                              child: TextFormField(
                                controller: confrimPasswordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "Confirm Password"),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 230,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 217, 217, 217)),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BeatBoardDesktop(context)));
                                },
                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Container(),
            ],
          )),
    );
  }
}

class Functions {
  Future<void> validateAndSumbit(
      email, password, firstName, lastName, context) async {
    await AuthService().signUpWithEmailAndPassword(email, password);
    await AuthService().signInWithEmailAndPassword(email, password);
    await UserService()
        .createUser(FirebaseAuth.instance.currentUser, firstName, lastName);
  }
}

class CreateMobile extends StatefulWidget {
  const CreateMobile(BuildContext context, {super.key});

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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '../assets/images/ZiiQue-Logo.png',
              height: 120,
              width: 120,
              alignment: Alignment.topCenter,
            ),
            const SizedBox(width: 100),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("../assets/images/Ziique_back.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Column(
            children: [
              isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: TextFormField(
                                      controller: firstNameController,
                                      decoration: const InputDecoration(
                                          hintText: "First Name"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: TextFormField(
                                      controller: lastNameController,
                                      decoration: const InputDecoration(
                                          hintText: "Last Name"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: TextFormField(
                                      controller: eMailController,
                                      decoration: const InputDecoration(
                                          hintText: "Email"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          hintText: "Password"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: TextFormField(
                                      controller: confrimPasswordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          hintText: "Confirm Password"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 230,
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 217, 217, 217)),
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BeatBoardDesktop(context)));
                                      },
                                      child: const Text(
                                        "Create Account",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24),
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
          )),
    );
  }
}
