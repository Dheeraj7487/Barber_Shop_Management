import 'package:barber_booking_management/Login/screen/register_screen.dart';
import 'package:barber_booking_management/mixin/button_mixin.dart';
import 'package:barber_booking_management/mixin/textfield_mixin.dart';
import 'package:barber_booking_management/utils/app_color.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please sign in to continue',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 70),
                    const Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppColor.appColor),),
                    const SizedBox(height: 5),
                    TextFieldMixin().textFieldWidget(
                      cursorColor: Colors.black,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter email",
                      prefixIcon: const Icon(Icons.email_outlined,color: AppColor.appColor),
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.trim().isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@"
                            r"[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    const Text('Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppColor.appColor),),
                    const SizedBox(height: 5),
                    TextFieldMixin().textFieldWidget(
                        cursorColor: Colors.black,
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Enter password",
                        prefixIcon: const Icon(Icons.lock_outline,color: AppColor.appColor),
                        // suffixIcon: const Icon(Icons.visibility_off_outlined),
                      obscureText: passwordVisibility ? false : true,
                      suffixIcon: IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                          icon: passwordVisibility
                              ? const Icon(
                            Icons.visibility,
                            color: AppColor.appColor,
                          )
                              : const Icon(Icons.visibility_off,
                              color: AppColor.appColor)),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                        onTap: (){
                          if(_formKey.currentState!.validate()){}
                        },
                        child: ButtonMixin().appButton(text: 'Login'))

                  ],
                ),
              ),
            ),
          ),
        ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: const Text(
              'Don' "'" 't Have An Account Yet?  ',
              style: TextStyle(
                  decorationThickness: 2,
                  decoration: TextDecoration.none,
                  color:AppColor.blackColor),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 25),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 18,
                    decorationThickness: 1,
                    color:AppColor.appColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
