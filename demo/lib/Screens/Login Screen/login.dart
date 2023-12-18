import 'package:demo/Screens/Home%20Screen/home_screen.dart';
import 'package:demo/utils/custom_snackbar.dart';
import 'package:demo/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../GetX Controller/Login Controller/login_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/app_images.dart';
import '../Registration Screen/registraton screen.dart';

class Login extends StatefulWidget {
  final String email;
  final String password;
  const Login({super.key, required this.email, required this.password,});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.put(LoginController());

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(height: 50,),
            Image.asset(AppImages.loginImg,height: 200,),
            const Center(
              child: Text(
                "Login",
                style: TextStyle(color: Colors.black, fontSize: 28,fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email,color: AppColor.grey,),
                  hintText: "enter email",
                  hintStyle: TextStyle(color: AppColor.grey)
              ),
              validator: Validation.validateEmail,
              onChanged: (val) {
                formKey.currentState?.validate();
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(
              () => TextFormField(
                obscureText: controller.isObscure.value,
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: AppColor.grey,),
                  hintText: "enter password",
                  hintStyle: const TextStyle(color: AppColor.grey),
                  suffixIcon: IconButton(
                      icon: Icon(
                          controller.isObscure.isTrue
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColor.grey,
                          size: 18),
                      onPressed: () {
                        // setTextField(() {
                        controller.isObscure.value =
                            !controller.isObscure.value;
                        // });
                      }),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  formKey.currentState?.validate();
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    backgroundColor: Colors.blue),
                onPressed: () {
                  var validate = formKey.currentState?.validate();
                  if (validate != null && validate) {
                    FocusScope.of(context).unfocus();
                    if(emailController.text != widget.email || passwordController.text != widget.password){
                      CustomSnackBar.mySnackBar(context, "user not exist");
                    }
                    else if(passwordController.text != widget.password){
                      CustomSnackBar.mySnackBar(context, "invalid password");
                    }
                    else{
                      Get.offAll(()=> HomeScreen(),transition: Transition.rightToLeft);
                    }
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white,fontSize: 16),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("New User?",style: TextStyle(fontSize: 16),),
                TextButton(
                    onPressed: () {
                      Get.to(() => const RegistrationScreen());
                    },
                    child: const Text("Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            decoration: TextDecoration.underline)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
