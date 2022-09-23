import 'dart:io';
import 'package:barber_booking_management/Addshop/provider/add_shop_provider.dart';
import 'package:barber_booking_management/Login/firebase_auth/login_auth.dart';
import 'package:barber_booking_management/Login/provider/login_provider.dart';
import 'package:barber_booking_management/Login/screen/login_screen.dart';
import 'package:barber_booking_management/mixin/button_mixin.dart';
import 'package:barber_booking_management/mixin/textfield_mixin.dart';
import 'package:barber_booking_management/utils/app_color.dart';
import 'package:barber_booking_management/utils/app_image.dart';
import 'package:barber_booking_management/widget/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_prefrence_key.dart';
import '../../utils/app_utils.dart';
import '../provider/loading_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegExp passwordValidation = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  final _formKey = GlobalKey<FormState>();
  File? file;
  // late UserCredential userCredential;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LoginProvider>(context,listen: false).onWillPop(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void selectImage(BuildContext context) async{
    //Pick Image File
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image
    );
    if(result == null) return;
    final filePath = result.files.single.path;
    File compressImage = await AddShopProvider().imageSizeCompress(image: File(filePath!));
    setState((){
      file = compressImage;
    });
  }

  void uploadFile(context) async {
    if (file == null) return;
    final fireauth = FirebaseAuth.instance.currentUser?.email;
    final destination = 'images/$fireauth';
    try {
      final ref = FirebaseStorage.instance.ref().child(destination);
      UploadTask uploadsTask =  ref.putFile(file!);
      final snapshot = await uploadsTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL().whenComplete(() {});
      User? user = await LoginAuth.registerUsingEmailPassword(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text.trim(),
          mobile: phoneController.text.trim(),
          context: context
      );
      if (user != null) {
        LoginProvider().addUserDetail(
          uId: FirebaseAuth.instance.currentUser!.uid,
            userName: nameController.text,
            userEmail: emailController.text, userMobile: phoneController.text,
            userImage: imageUrl, timestamp: Timestamp.now(),
            shopDescription: '', barberImage: '', webSiteUrl: '',
            status: '', barberName: '',
            gender: '', longitudeShop: '', shopImage: '', address: '',
            rating: 0.1, shopName: '', hairCategory: '', currentUser: '',
            latitudeShop: '', openingHour: '', coverPageImage: '', contactNumber: '', price: '',
            userType: Provider.of<LoginProvider>(context,listen: false).selectUserType.toString(), closingHour: '').then((value) {
          AppUtils.instance.showToast(toastMessage: "Register Successfully");
          AppUtils.instance.setPref(PreferenceKey.boolKey, PreferenceKey.prefLogin, true);
          AppUtils.instance.setPref(PreferenceKey.stringKey, PreferenceKey.prefEmail, emailController.text);
          Provider.of<LoginProvider>(context,listen:false).getSharedPreferenceData(emailController.text);
          Provider.of<LoadingProvider>(context,listen: false).stopLoading();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomNavBarScreen()));
        });

        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      debugPrint("Image URL = $imageUrl");
    } catch (e) {
      debugPrint('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0,left: 20,right: 20),
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

                    Center(
                      child: Stack(
                          clipBehavior: Clip.none,
                          children : [
                            GestureDetector(
                              onTap: (){
                                selectImage(context);
                              },
                              child: ClipOval(
                                child: file == null ?
                                Image.asset(
                                    AppImage.user,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill) :
                                Image.file(
                                  file!,
                                  height: 80,width: 80,
                                  fit: BoxFit.fill,),
                              ),
                            ),
                            Positioned(
                              left: 60,
                              top: 50,
                              child: ClipOval(
                                  child: Container(
                                    height: 30,width: 30,
                                    color:Colors.white,child: const Icon(Icons.camera_alt,color: AppColor.appColor,size: 22,),)),
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Full Name',style: TextStyle(color: AppColor.appColor),),
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
                    const Text('Email',style: TextStyle(color: AppColor.appColor),),
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
                    const Text('Mobile Number',style: TextStyle(color: AppColor.appColor),),
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
                    const Text('User Type',style: TextStyle(color: AppColor.appColor),),
                    const SizedBox(height: 5),
                    Consumer<LoginProvider>(
                        builder: (BuildContext context, snapshot, Widget? child) {
                        return Container(
                          padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5,right: 20),
                          decoration: BoxDecoration(
                            color: AppColor.blackColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)
                          ),

                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide.none)),
                            value: snapshot.selectUserType,
                            validator: (value) {
                              if (value == null) {
                                return 'User type is required';
                              }
                              return null;
                            },
                            hint: const Text('Select User Type'),
                            isExpanded: true,
                            isDense: true,
                            style: const TextStyle(color: AppColor.blackColor),
                            icon: const Icon(Icons.arrow_drop_down),
                            onChanged: (String? newValue) {
                              snapshot.selectUserType = newValue!;
                              snapshot.getUserType;
                            },
                            items: snapshot.selectUserTypeList
                                .map<DropdownMenuItem<String>>((String userType) {
                              return DropdownMenuItem<String>(
                                  value: userType,
                                  child: Row(
                                    children: [
                                      Text(userType)
                                    ],
                                  )
                              );
                            }).toList(),
                          ),
                        );
                      }
                    ),

                    const SizedBox(height: 20),
                    const Text('Password',style: TextStyle(color: AppColor.appColor),),
                    const SizedBox(height: 5),
                    TextFieldMixin().textFieldWidget(
                      cursorColor: Colors.black,
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
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
                    const Text('Confirm Password',style: TextStyle(color: AppColor.appColor),),
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
                        onTap: () async{
                          if(_formKey.currentState!.validate()){
                            Provider.of<LoadingProvider>(context,listen: false).startLoading();
                            if(file !=null){
                              uploadFile(context);
                            }
                            else{
                            User? user = await LoginAuth.registerUsingEmailPassword(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text.trim(),
                                mobile: phoneController.text.trim(),
                                context: context
                            );
                            if (user != null) {
                              AppUtils.instance.showToast(toastMessage: "Register Successfully");
                              LoginProvider().addUserDetail(
                                  userName: nameController.text,
                                  userEmail: emailController.text, userMobile: phoneController.text,
                                  uId: FirebaseAuth.instance.currentUser!.uid,
                                  userImage: '', timestamp: Timestamp.now(),
                                  shopDescription: '', barberImage: '', webSiteUrl: '',
                                  status: '', barberName: '',
                                  gender: '', longitudeShop: '', shopImage: '', address: '',
                                  rating: 0.1, shopName: '', hairCategory: '', currentUser: '',
                                  latitudeShop: '', openingHour: '', coverPageImage: '', contactNumber: '', price: '',
                                  userType : Provider.of<LoginProvider>(context,listen: false).selectUserType.toString(), closingHour: '');
                              AppUtils.instance.setPref(PreferenceKey.boolKey, PreferenceKey.prefLogin, true);
                              AppUtils.instance.setPref(PreferenceKey.stringKey, PreferenceKey.prefEmail, emailController.text);
                              Provider.of<LoadingProvider>(context,listen: false).stopLoading();
                              Provider.of<LoginProvider>(context,listen:false).getSharedPreferenceData(emailController.text);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomNavBarScreen()));
                            }
                          }
                          }
                        },
                        child: ButtonMixin().appButton(text: 'Sign Up')),
                    const SizedBox(height: 20),

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
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 25),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 16,
                      decorationThickness: 1,
                      color:AppColor.appColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
