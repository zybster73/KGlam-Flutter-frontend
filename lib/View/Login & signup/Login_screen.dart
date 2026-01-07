import 'package:KGlam/Services/auth_Provider.dart';
import 'package:KGlam/Services/notificationServices.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:KGlam/Services/validations.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    final notifyService = Provider.of<Notificationservices>(
      context,
      listen: false,
    );
    notifyService.listenToTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final notifyService = Provider.of<Notificationservices>(context);
    final validations = Provider.of<Validations>(context);
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
                        top: 8.0,
                        left: 8,
                        right: 8,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: emailController,
                              labelText: 'Email / Phone Number',
                              hintText: 'Enter Email Or Phone Number',
                              errorText: validations.emailError,
                              onChanged: (value) {
                                validations.validateEmail(value);
                              },
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: passwordController,
                              labelText: "Password",
                              hintText: "Enter Password",
                              obscureText: true,
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
                                final result = await authProvier.loginApi(
                                  userInput,
                                  passwordController.text,
                                );

                                if (result['success'] == true) {
                                  await notifyService.tokensentAfterLogin();
                                  if (result['data']['data']['role'] == 'owner') {
                                    print(result['data']['role']);
                                    final salon =
                                        result['data']['data']['salon'];
                                    if (salon == null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SaloonInformation(),
                                        ),
                                      );
                                    } else {
                                      await Storetoken.saveSalonId(salon['id']);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomNavigationBar(),
                                        ),
                                        ModalRoute.withName('/'),
                                      );
                                    }
                                  } else if (result['data']['data']['role'] == 'customer') {
                                    Future.microtask(() {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Usernavigationbar(),
                                        ),
                                        ModalRoute.withName('/'),
                                      );
                                    });
                                  }
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
                                    
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterScreen(
                                            index: widget.index,
                                          ),
                                        ),
                                      );
                              
                                  },
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.poppins(
                                      color:
                                    
                                          Color(0xFF01ABAB),
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
