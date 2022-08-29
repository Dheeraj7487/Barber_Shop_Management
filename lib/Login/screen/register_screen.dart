import 'package:barber_booking_management/Login/screen/login_screen.dart';
import 'package:barber_booking_management/mixin/button_mixin.dart';
import 'package:barber_booking_management/mixin/textfield_mixin.dart';
import 'package:barber_booking_management/utils/app_color.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegExp passwordValidation = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  final _formKey = GlobalKey<FormState>();

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
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please sign up to continue',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),

                  const Text('Full Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppColor.appColor),),
                  const SizedBox(height: 5),
                  TextFieldMixin().textFieldWidget(
                      cursorColor: Colors.black,
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      hintText: "Enter Name",
                      prefixIcon: const Icon(Icons.person_outline,color: AppColor.appColor),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
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
                  const Text('Mobile Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppColor.appColor),),
                  const SizedBox(height: 5),
                  TextFieldMixin().textFieldWidget(
                    cursorColor: Colors.black,
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    hintText: "Enter Phone Number",
                    prefixIcon: const Icon(Icons.phone_android_outlined,color: AppColor.appColor),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return 'Please enter phone number';
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
                    suffixIcon: const Icon(Icons.visibility_off_outlined),
                    validator: (value) {
                      if (value!.isEmpty || value.trim().isEmpty) {
                        return 'Enter valid password';
                      } else if (!passwordValidation
                          .hasMatch(passwordController.text)) {
                        return 'Password must contain at least one number and both lower upper case letters and special characters.';
                      } else if (value.length < 8) {
                        return 'Password must be atLeast 8 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  const Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppColor.appColor),),
                  const SizedBox(height: 5),
                  TextFieldMixin().textFieldWidget(
                    cursorColor: Colors.black,
                    controller: confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Enter password",
                    prefixIcon: const Icon(Icons.lock_outline,color: AppColor.appColor),
                    suffixIcon: const Icon(Icons.visibility_off_outlined),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter confirm password!';
                      }
                      if (value != passwordController.text) {
                        return "Password does Not Match";
                      } else if (passwordController.text.isNotEmpty &&
                          passwordController.text.length >= 8 &&
                          passwordController.text.length <= 16 &&
                          !passwordController.text.contains(' ') &&
                          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(
                              passwordController.text.toString())) {
                        return null;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),
                  GestureDetector(
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                        }
                      },
                      child: ButtonMixin().appButton(text: 'Sign Up'))

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
              'Already Have An Account?  ',
              style: TextStyle(
                  decorationThickness: 2,
                  decoration: TextDecoration.none,
                  color:AppColor.blackColor),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 25),
              child: const Text(
                'Sign In',
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
