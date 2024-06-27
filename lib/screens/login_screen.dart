import 'package:flutter/material.dart';
import 'package:halicmedia/resources/auth_methods.dart';
import 'package:halicmedia/responsive/mobile_screen_layout.dart';
import 'package:halicmedia/screens/signup_screen.dart';
import 'package:halicmedia/utils/utils.dart';
import 'package:halicmedia/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading=true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    
    if(res =="success"){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MobileScreenLayout(),));

    }else{
      showSnackbar(context, res);

    }
    setState(() {
      _isLoading=false;
    });
  }
  void navigateToSignup(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: 
      SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 52),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //Logo
              Padding(padding: EdgeInsets.only(left: 30),child: Image.asset("assets/logo.png",)),
              const SizedBox(
                height: 64,
              ),
              //TextField Email
              TextFieldInput(
                  icon: Icon(Icons.email,color: Colors.white,),
                  textEditingController: _emailController,
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  
                  ),
              const SizedBox(
                height: 24,
              ),

              //TextField Password
              TextFieldInput(
                icon: Icon(Icons.lock,color: Colors.white,),
                textEditingController: _passwordController,
                hintText: "Şifre",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 64,
              ),

              //Login Button
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          "Giriş Yap",
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
                      "Hesabınız yok mu?",
                      style: TextStyle(color: Colors.black),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: Text(
                        "Oluşturun!",
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
              
            ],
          ),
        ),
      ),
    );
  }
}
