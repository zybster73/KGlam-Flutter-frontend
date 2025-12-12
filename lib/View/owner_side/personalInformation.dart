import 'package:KGlam/Services/salon_Api_provider.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:KGlam/View/selectRole.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:provider/provider.dart';

class Personalinformation extends StatefulWidget {
  const Personalinformation({super.key});

  @override
  State<Personalinformation> createState() => _PersonalinformationState();
}

class _PersonalinformationState extends State<Personalinformation> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    String? token = await Storetoken.getToken();
    print("Fetched token: $token");

    if (token == null) {
      print("No token found, user not logged in");
      return;
    }

    var data = await SalonApiProvider().getUserDetails();

    if (data != null) {
      setState(() {
        userName.text = data['username'] ?? "";
        emailCtrl.text = data['email'] ?? "";
        PhoneNum.text = data['contact_number'] ?? "";
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  TextEditingController userName = TextEditingController();
  TextEditingController PhoneNum = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final salonApi = Provider.of<SalonApiProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                            Navigator.pop(context);
                            // if (widget.onBack != null) {
                            //   widget.onBack!();
                            // } else {
                            //   Navigator.pop(context);
                            // }
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
                                'Personal Information',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Update your Personal Information\n from here',
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
                  CircleAvatar(
                    backgroundColor: Colors.black12,
                    radius: 50.r,
                    child: Icon(Icons.person, size: 55.sp, color: Colors.grey),
                  ),
                  SizedBox(width: 10.w),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Imtisal Hassan',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Imtisalhassan968@gmail.com',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),
            isLoading
                ? CircularProgressIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 1.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: userName,
                          labelText: 'User Name',
                          hintText: "Imtisal Hassan",
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: emailCtrl,
                          labelText: "Email",
                          hintText: "Imtisalhassan968@gmail.com",
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
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: newPassword,
                          labelText: "New Password",
                          hintText: "***********",
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: confirmPassword,
                          labelText: "Confirm New Password",
                          hintText: "**********",
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
                    oldPassword.text,
                    newPassword.text,
                    confirmPassword.text,
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
                    ? CircularProgressIndicator()
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
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
