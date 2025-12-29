import 'package:KGlam/Services/auth_Provider.dart';
import 'package:KGlam/Services/validations.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/Login%20&%20signup/verifyEmail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/CustomWidgets/CustomTextField.dart';
import 'package:KGlam/View/Login%20&%20signup/Login_screen.dart';
import 'package:KGlam/View/Login%20&%20signup/saloon_information.dart';
import 'package:KGlam/View/user_side/UserNavigationBar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final String? index;
  RegisterScreen({this.index});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController UserName = TextEditingController();
  TextEditingController emailphoneNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Utils.instance.initToast(context);
    print(widget.index);
    final authProvier = Provider.of<AuthProvider>(context);
    final validations = Provider.of<Validations>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF01ABAB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.28,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -0.05 * screenHeight,
                  left: -0.10,
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
                  'Register into your account',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  'Effortlessly register, access your account and\n enjoy seamless convenience. ',
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
          SizedBox(height: screenHeight * 0.03),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                        top: 15.0,
                        left: 8,
                        right: 8,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: UserName,
                              hintText: "Enter User Name",
                              labelText: 'User Name',
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: emailphoneNumberController,
                              labelText: 'Email',
                              hintText: 'Enter Email ',
                              errorText: validations.emailError,
                              onChanged: (value) {
                                validations.validateEmail(
                                  value,
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: phoneNumberController,
                              labelText: "Phone Number",
                              hintText: "Enter Phone Number",
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: passwordController,
                              labelText: "Password",
                              hintText: "Enter Password",
                              obscureText: true,
                              errorText: validations.passwordError,
                              onChanged: (value) {
                                validations.validatePassword(value);
                              },
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: confirmPassword,
                              labelText: "Confirm Password",
                              hintText: "Enter Password",
                              obscureText: true,
                              errorText: validations.confirmPasswordError,
                              onChanged: (value) {
                                validations.validateConfirmPassword(
                                  password: passwordController.text,
                                  confirmPassword: value,
                                );
                              },
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () async {
                                final result = await authProvier.signUp(
                                  UserName.text.toLowerCase(),
                                  emailphoneNumberController.text,
                                  phoneNumberController.text,
                                  passwordController.text,
                                  confirmPassword.text,
                                  widget.index,
                                );
                                if (result['success'] == true) {
                                  Future.microtask(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Verifyemail(
                                          email:
                                              emailphoneNumberController.text,
                                          index: widget.index,
                                        ),
                                      ),
                                    );
                                  });
                                }
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
                                        'Register',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Have an Account?',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreen(index: widget.index),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Color(0xFF01ABAB),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
