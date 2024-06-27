import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:halicmedia/resources/auth_methods.dart';
import 'package:halicmedia/responsive/mobile_screen_layout.dart';
import 'package:halicmedia/screens/login_screen.dart';
import 'package:halicmedia/utils/utils.dart';
import 'package:halicmedia/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;

  Uint8List? _image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      bio: _bioController.text,
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackbar(context, res);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MobileScreenLayout(),));
    }
  }
    void navigateToLogin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
 
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //Logo
              Padding(padding: EdgeInsets.only(left: 50,top: 20),child: Image.asset("assets/logo.png")),
              const SizedBox(
                height: 64,
              ),
              // image select
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png"),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              //TextField Username
              TextFieldInput(
                  icon: Icon(Icons.add),
                  textEditingController: _usernameController,
                  hintText: "Kullanıcı Adı",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),

              //TextField Email
              TextFieldInput(
                  icon: Icon(Icons.email),
                  textEditingController: _emailController,
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),

              //TextField Password
              TextFieldInput(
                icon: Icon(Icons.lock),
                textEditingController: _passwordController,
                hintText: "Şifre",
                textInputType: TextInputType.text,
                isPass: true,
                
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  icon: Icon(Icons.subtitles),
                  textEditingController: _bioController,
                  hintText: "Hakkında",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 64,
              ),

              //Login Button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          "Kayıt Ol",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Hesabınız var mı ?",
                      style: TextStyle(color: Colors.black),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap:  navigateToLogin,
                    child: Container(
                      child: Text(
                        "Giriş Yapın!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                    ),
                  )
                ],
              )
              //Transitioning to signup
            ],
          ),
        ),
      ),
    );
  }
}
