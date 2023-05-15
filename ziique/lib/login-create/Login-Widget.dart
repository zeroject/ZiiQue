import 'package:flutter/material.dart';
import 'package:ziique/BeatBoard/beat_board-Widget.dart';
import 'package:ziique/FireService/fire_auth_service.dart';

class LoginDesktop extends StatelessWidget {
  LoginDesktop(BuildContext context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/blue-background.png"),
              fit: BoxFit.none,
            )
        ),
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 250,
                child: Image.asset("assets/images/Ziique-logo.png"),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: 400,
                          child: TextFormField(controller: emailController,decoration: InputDecoration(hintText: "Email"),)),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 400,
                          child: TextFormField(controller: passwordController ,obscureText: true, decoration: InputDecoration(hintText: "Password"),)),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 200,
                          height: 40,
                          child: ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 217, 217, 217)), 
                          onPressed: (){ 
                            Functions().validateAndSumbit(emailController.text, passwordController.text, context);
                            }, 
                          child: const Text("Log In", style: TextStyle(fontSize: 24, color: Colors.black),))
                      ),
                      const SizedBox(
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
  LoginMobile(BuildContext context, {super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/blue-background.png"),
              fit: BoxFit.none,
            )
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.white
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    SizedBox(
                        width: 400,
                        child: TextFormField(controller: emailController,decoration: InputDecoration(hintText: "Email"),)),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: 400,
                        child: TextFormField(controller: passwordController ,obscureText: true, decoration: InputDecoration(hintText: "Password"),)),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 217, 217, 217)),
                            onPressed: (){
                              Functions().validateAndSumbit(emailController.text, passwordController.text, context);
                            },
                            child: const Text("Log In", style: TextStyle(fontSize: 24, color: Colors.black),))
                    ),
                    const SizedBox(
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
    );
  }
}

class Functions{
  Future<void> validateAndSumbit(email, password, context) async{
    await SignInService().SignInWithEmailAndPassword(email, password);
    Navigator.push(context, MaterialPageRoute(builder: (context) => BeatBoardDesktop(context)));
  }
}