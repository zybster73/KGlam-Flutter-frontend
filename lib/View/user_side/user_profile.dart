import 'dart:io';

import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/Services/validations.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:KGlam/View/CustomWidgets/ShimmerText.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/CustomWidgets/shimmerEffectlist.dart';
import 'package:KGlam/View/selectRole.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  final VoidCallback? onBack;
  const UserProfile({super.key, this.onBack});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController userName = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController PhoneNum = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
    nameEmail();
  }

  bool isloading = true;

  String email = '';
  String name = '';
  String _profileImageUrl = '';
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> fetchUserData() async {
    final data = await SalonApiProvider().getUserDetails();

    if (data != null) {
      setState(() {
        userName.text = data['username'];
        emailCtrl.text = data['email'];
        PhoneNum.text = data['contact_number'];
        _profileImageUrl = data['profile_image'] ?? '';
        isloading = false;
      });
    }
  }

  Future<void> nameEmail() async {
    final data = await SalonApiProvider().getUserDetails();

    if (data != null) {
      setState(() {
        name = data['username'];
        email = data['email'];

        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
    final validations = Provider.of<Validations>(context);
    final salonApi = Provider.of<SalonApiProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  ModalProgressHUD(
      inAsyncCall: salonApi.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 215,
                child: Stack(
                  children: [
                    Positioned(
                      top: -0.05 * screenHeight,
                      left: -10,
                      child: Image.asset(
                        'assets/images/Eclipse2.png',
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.9,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 50.h,
                      left: 20.w,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFF01ABAB),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              if (widget.onBack != null) {
                                widget.onBack!();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            iconSize: 18,
                            padding: EdgeInsets.zero,
                            color: Colors.white,
      
                            icon: Icon(Icons.arrow_back_ios_sharp),
                          ),
                        ),
                      ),
                    ),
      
                    Padding(
                      padding: EdgeInsets.only(
                        top: 115.h,
                        left: 10.w,
                        right: 20.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Profile',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Discover your beautiful story inside\n profile.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
      
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.black12,
      
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!) // 1️⃣ Local image
                            : (_profileImageUrl.isNotEmpty
                                  ? NetworkImage(
                                      _profileImageUrl,
                                    ) // 2️⃣ Backend image
                                  : null), // 3️⃣ No image
      
                        child:
                            (_selectedImage == null && _profileImageUrl.isEmpty)
                            ? Icon(
                                Icons.camera_alt,
                                size: 30.sp,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
      
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isloading ?  ShimmerText(width: 120, height: 16) :
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       SizedBox(height: 6),
                      isloading ?  ShimmerText(width: 180, height: 16) :
                      Text(email, style: GoogleFonts.poppins(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
      
              SizedBox(height: 10.h),

              isloading
                ? ShimmerEffectlist(itemCount: 6, height: 50)
                :
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          CustomTextField(
                            readonly: true,
                            controller: userName,
                            labelText: 'User Name',
                            hintText: "Abdullah Khan",
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            readonly: true,
                            controller: emailCtrl,
                            labelText: "Email",
                            hintText: "abdullahkhanh2@gmail.com",
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: PhoneNum,
                            labelText: 'Phone Number',
                            hintText: 'Enter Phone Number',
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: oldPassword,
                            labelText: "Old Password",
                            hintText: "*********",
                            obscureText: true,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: newPassword,
                            labelText: "New Password",
                            hintText: "***********",
                            obscureText: true,
                            errorText: validations.passwordError,
                            onChanged: (value) {
                              validations.validatePassword(value);
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: confirmPassword,
                            labelText: "Confirm New Password",
                            hintText: "**********",
                            obscureText: true,
                            errorText: validations.confirmPasswordError,
                            onChanged: (value) {
                              validations.validateConfirmPassword(
                                password: confirmPassword.text,
                                confirmPassword: value,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    bool success = await salonApi.updateUserDetails(
                      oldPassword: oldPassword.text,
                      newPassword: newPassword.text,
                      confirmPassword: confirmPassword.text,
                      phoneNumber: PhoneNum.text,
                      profileImage: _selectedImage,
                    );
      
                    if (success) {
                      print('updated successfully');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01ABAB),
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: salonApi.isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Save Changes",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (bottomSheetContext) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/confirmation.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
      
                              Text(
                                "Delete Account",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
      
                              Text(
                                "Are you sure you want to delete the Account?",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SelectRole(),
                                          ),
                                          ModalRoute.withName('/'),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        "Yes",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
      
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        side: BorderSide(color: Colors.black26),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        "No",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black87,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    "Delete Account",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }
}
