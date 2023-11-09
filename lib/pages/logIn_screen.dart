import 'package:ecom_user_app/auth/auth_service.dart';
import 'package:ecom_user_app/pages/launcher_screen.dart';
import 'package:ecom_user_app/providers/user_prodiver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../style/style_file.dart';

class LogInScreen extends StatefulWidget {
  static String routeName = '/login';

  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  String errMSg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: appInputStyle(
                    'Email ',
                    const Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: TextFormField(
                  obscureText: isVisible,
                  controller: _passController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(
                          isVisible ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 130,
                height: 50,
                child: ElevatedButton(
                  style: buttonStyle(),
                  onPressed: (){
                    _authenticate(true);
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New User?'),
                  TextButton(
                    onPressed: (){},
                    child: const Text('Register Here'),
                  ),
                ],
              ),
              const Center(
                child: Text('OR'),
              ),
              SizedBox(
                width: 130,
                height: 50,
                child: ElevatedButton(
                  style: buttonStyle(),
                  onPressed: (){
                    _authenticate(false);
                  },
                  child: const Text(
                    'Sing In With Google',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    errMSg,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _authenticate(bool isLogin) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passController.text;
      EasyLoading.show(status: 'Please Wait');
      User user;
      try{
        if(isLogin){
          user =  await AuthService.loginUser(email, password);
        }else{
          user =  await AuthService.registerUser(email, password);
         await Provider.of<UserProvider>(context ,listen: false)
          .addNewUser(user);
        }
        EasyLoading.dismiss();
        Navigator.pushNamed(context, LauncherScreen.routeName);
      } on FirebaseAuthException catch (error){
        EasyLoading.dismiss();
        setState(() {
          errMSg = error.message!;
        });
      }

    }
  }
}
