import 'dart:io';
import 'package:demo/Screens/Login%20Screen/login.dart';
import 'package:demo/utils/app_images.dart';
import 'package:demo/utils/validation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Component/custom_button.dart';
import '../../utils/app_color.dart';
import '../../utils/custom_snackbar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final addressController = TextEditingController();
  File? _image;
  XFile? imageFile;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  openGallery() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      print('Android $release (SDK $sdkInt), $manufacturer $model');
      // print("check version ${sdkInt > 32}");
      if (sdkInt > 32) {
        imageFile = await picker.pickImage(source: ImageSource.gallery);
        if (imageFile != null) {
          setState(() {
            _image = File(imageFile!.path);
          });
        }
      } else {
        var cameraStatus = await Permission.camera.status;
        var storageStatus = await Permission.storage.status;
        PermissionStatus? cameraShowAlert;
        PermissionStatus? storageShowAlert;
        if (!cameraStatus.isGranted) {
          cameraShowAlert = await Permission.camera.request();
        }
        if (!storageStatus.isGranted) {
          storageShowAlert = await Permission.storage.request();
        }
        if (await Permission.camera.isGranted) {
          if (await Permission.storage.isGranted) {
            imageFile = await picker.pickImage(
                source: ImageSource.gallery, imageQuality: 20);
            if (imageFile != null) {
              setState(() {
                _image = File(imageFile!.path);
              });
            }
          } else {
            CustomSnackBar.mySnackBar(
              context,
              "Allow permission to access media.",
              action: SnackBarAction(
                  textColor: AppColor.black,
                  label: "allow",
                  onPressed: () async {
                    await openAppSettings();
                  }),
            );
          }
        } else {
          if (cameraShowAlert == PermissionStatus.permanentlyDenied ||
              storageShowAlert == PermissionStatus.permanentlyDenied) {
            await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      title: const Text('Requires Camera Permission'),
                      content: const Text(
                          'This application requires access to your camera and storage'),
                      actions: <Widget>[
                        CustomButton(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent),
                          textColor: AppColor.white,
                          buttonText: 'Allow',
                          onPressed: () async {
                            await openAppSettings();
                            Get.back();
                          },
                        ),
                        CustomButton(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red),
                          textColor: AppColor.white,
                          buttonText: 'Cancel',
                          onPressed: () async {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                });
          } else {
            print("Camera access denied!.. $cameraStatus and $storageStatus");
          }
        }
      }
    }
  }

  openCamera() async {
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;
    PermissionStatus? cameraShowAlert;
    PermissionStatus? storageShowAlert;
    if (!cameraStatus.isGranted) {
      cameraShowAlert = await Permission.camera.request();
    }
    if (!storageStatus.isGranted) {
      storageShowAlert = await Permission.storage.request();
    }
    if (await Permission.camera.isGranted) {
      if (await Permission.storage.isGranted) {
        imageFile = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 20);
        if (imageFile != null) {
          setState(() {
            _image = File(imageFile!.path);
          });
        }
      } else {
        print("Camera needs to access your storage, please provide permission");
      }
    } else {
      if (cameraShowAlert == PermissionStatus.permanentlyDenied ||
          storageShowAlert == PermissionStatus.permanentlyDenied) {
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: const Text('Requires Camera Permission'),
                  content: const Text(
                      'This application requires access to your camera and storage'),
                  actions: <Widget>[
                    CustomButton(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                      textColor: AppColor.white,
                      buttonText: 'Allow',
                      onPressed: () async {
                        await openAppSettings();
                        Get.back();
                      },
                    ),
                    CustomButton(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red),
                      textColor: AppColor.white,
                      buttonText: 'Cancel',
                      onPressed: () async {
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            });
      } else {
        print("Provide Camera permission to use camera.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "Registration",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 28),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            Center(
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: 128,
                    width: 128,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x1A818181)),
                    child: _image != null
                        ? Image.file(
                      _image!,
                      // File(image?.path),
                      fit: BoxFit.cover,
                    )
                        : Image.asset(AppImages.profile),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        /// Show Pop Up
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Change Profile",
                                textAlign: TextAlign.center),
                            content: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.photo_album_rounded,
                                  ),
                                  color: AppColor.black,
                                  iconSize: 30,
                                  onPressed: () async {
                                    Get.back();
                                    openGallery();
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                      Icons.camera_alt_rounded),
                                  color: Colors.grey,
                                  iconSize: 30,
                                  onPressed: () async {
                                    Get.back();
                                    openCamera();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white),
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColor.grey,
                            child: Icon(
                              Icons.edit,
                              color: AppColor.white,
                            )
                          //SvgPicture.asset(ConstanceData.editIcon, height: 15,color: Colors.white,),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            /// Name TextField
            TextFormField(
                controller: nameController,
                onChanged: (val) {
                  formKey.currentState?.validate();
                },
                decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.account_circle, color: AppColor.grey),
                    hintText: "enter name",
                    hintStyle: TextStyle(color: AppColor.grey)),
                validator: Validation.validateAlphanumeric),
            const SizedBox(
              height: 20,
            ),

            /// Email TextField
            TextFormField(
                controller: emailController,
                onChanged: (val) {
                  formKey.currentState?.validate();
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email, color: AppColor.grey),
                    hintText: "enter email",
                    hintStyle: TextStyle(color: AppColor.grey)),
                validator: Validation.validateEmail),
            const SizedBox(
              height: 20,
            ),

            /// Password TextField
            TextFormField(
              controller: passwordController,
              onChanged: (val) {
                formKey.currentState?.validate();
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: AppColor.grey),
                  hintText: "enter password",
                  hintStyle: TextStyle(color: AppColor.grey)),
              validator: Validation.validatePass,
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
                controller: mobileNumberController,
                onChanged: (val) {
                  formKey.currentState?.validate();
                },
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"\d"), // allow only numbers
                  )
                ],
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_android, color: AppColor.grey),
                    hintText: "enter mobile number",
                    hintStyle: TextStyle(color: AppColor.grey)),
                keyboardType: TextInputType.number,
                validator: Validation.validateMobile),

            TextFormField(
              validator: Validation.validate,
              controller: addressController,
              onChanged: (val) {
                formKey.currentState?.validate();
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z\d]+|\s")),
              ],
              // verticalContentPadding: 10,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.home_filled, color: AppColor.grey),
                hintText: "Enter Address",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    backgroundColor: Colors.blue),
                onPressed: () {
                  var validate = formKey.currentState?.validate();
                  if (validate != null && validate) {
                    if(_image == null){
                      FocusScope.of(context).unfocus();
                      Get.dialog<void>(
                          barrierDismissible: false,
                          WillPopScope(
                            onWillPop: () async => false,
                            child: CupertinoAlertDialog(
                                title:  Text("Select Image"),
                                content: TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                                ),
                          ));
                    }
                    else{
                      FocusScope.of(context).unfocus();
                      Get.off(() => Login(
                        email: emailController.text,
                        password: passwordController.text,
                      ));
                    }
                  }
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
