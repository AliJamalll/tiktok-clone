import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';

import '../../../constants.dart';
import '../../widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _userController = TextEditingController();


   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TikTok Clone',
                  style: TextStyle(
                      fontSize: 35,
                      color: buttonColor,
                      fontWeight: FontWeight.w900
                  ),
                ),
                Text('Register',
                  style: TextStyle(
                      fontSize: 25,
                      color: buttonColor,
                      fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                    backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg',
                    ),
                      backgroundColor: Colors.black,
                  ),
                    Positioned(
                      top: 80,
                        left:70,
                        child: IconButton(
                          onPressed: () => authController.pickImage(),
                          icon: Icon(Icons.add_a_photo,size: 30,),
                        )
                    )
                ]
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                      controller: _userController,
                      icon: Icons.person,
                      labelText: 'Username'
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                      controller: _emailController,
                      icon: Icons.email,
                      labelText: 'Email'
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                      controller: _passwordController,
                      icon: Icons.lock,
                      labelText: 'Password',
                    isObscure: true,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width-40,
                  height: 50,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: InkWell(
                    onTap:()=>authController.registerUser(
                      _userController.text,
                      _emailController.text,
                      _passwordController.text,
                      authController.ProfilePhoto
                    ),
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(
                            fontSize: 20,
                            color: buttonColor
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
