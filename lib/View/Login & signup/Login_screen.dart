import 'package:KGlam/Services/auth_Provider.dart';
import 'package:KGlam/View/Login%20&%20signup/service_inforamtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/CustomNavigationBar.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/Login%20&%20signup/Forgot_password.dart';
import 'package:KGlam/View/Login%20&%20signup/Register_screen.dart';
import 'package:KGlam/View/Login%20&%20signup/saloon_information.dart';
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final String? index;
  final int? logicIndex;
  final int? logicIndexUser;
  LoginScreen({this.index, this.logicIndex, this.logicIndexUser});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController UserName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
    final authProvier = Provider.of<AuthProvider>(context);
    print(widget.index);
    print(widget.logicIndex);
    print(widget.logicIndexUser);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF01ABAB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -0.05 * screenHeight,
                  left: -10,
                  child: Image.asset(
                    'assets/images/Eclipse.png',
                    height: screenHeight * 0.35,
                    width: screenWidth * 0.9,
                    fit: BoxFit.contain,
                  ),
                ),

                Positioned(
                  top: screenHeight * 0.05 + 20,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/Logo.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login and let’s go !',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  'Unlock possibilities, start exploring,\n achieve more every single day. ',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8,
                          right: 8,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: emailController,
                              labelText: 'Email / Phone Number',
                              hintText: 'Enter Email Or Phone Number',
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: passwordController,
                              labelText: "Password",
                              hintText: "Enter Password",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotPassword(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Forget Password?',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFF01ABAB),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () async {
                                final userInput =
                                    emailController.text.isNotEmpty
                                    ? emailController.text
                                    : phoneNumber.text.isNotEmpty
                                    ? phoneNumber.text
                                    : UserName.text;
                                bool success = await authProvier.loginApi(
                                  userInput,
                                  passwordController.text,
                                );
                                if (success) {
                                  Future.microtask(() {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SaloonInformation(),
                                      ),
                                      ModalRoute.withName('/'),
                                    );
                                  });
                                }
                                // if (widget.index == 1) {
                                //   Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           CustomNavigationBar(),
                                //     ),
                                //     ModalRoute.withName('/'),
                                //   );
                                // } else if (widget.index == 2) {
                                //   Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => Usernavigationbar(),
                                //     ),
                                //     ModalRoute.withName('/'),
                                //   );
                                // } else if (widget.logicIndex == 1) {
                                //   Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           CustomNavigationBar(),
                                //     ),
                                //     ModalRoute.withName('/'),
                                //   );
                                // } else if (widget.logicIndexUser == 2) {
                                //   Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => Usernavigationbar(),
                                //     ),
                                //     ModalRoute.withName('/'),
                                //   );
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Color(0xFF01ABAB),
                                minimumSize: Size(
                                  MediaQuery.sizeOf(context).width * 0.96,
                                  48,
                                ),
                              ),
                              child: Center(
                                child: authProvier.isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Login',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don’t Have an Account ?',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (widget.logicIndex == 1 ||
                                        widget.logicIndexUser == 2) {
                                      Utils.instance.toastMessage(
                                        'You are already Have an Account Please Log in',
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.poppins(
                                      color:
                                          widget.logicIndex == 1 ||
                                              widget.logicIndexUser == 2
                                          ? Colors.grey
                                          : Color(0xFF01ABAB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
