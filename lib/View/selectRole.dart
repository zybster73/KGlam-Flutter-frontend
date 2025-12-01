import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/View/Login%20&%20signup/Register_screen.dart';

class SelectRole extends StatefulWidget {
  final int? index;
  SelectRole({this.index});
  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  int selectedRole = 0;

  @override
  Widget build(BuildContext context) {
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
                        width: 120,
                        height: 120,
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
                  'Select Role',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  'Please select your role whether you are a\nBarber or Saloon Owner.',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        roleCard(
                          context,
                          title: "Are you a saloon owner",
                          image: "assets/images/saloon_owner.png",
                          value: 1,
                        ),
                        
                        roleCard(
                          context,
                          title: "Are you a Customer",
                          image: "assets/images/customer.png",
                          value: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget roleCard(
    BuildContext context, {
    required String title,
    required String image,
    required int value,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final bool isSelected = selectedRole == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = value;
        });
        print(value);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen(index: value)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF01ABAB)
                  : Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                //blurRadius: 4,
                //offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: const Color(0xFF01ABAB),
                    size: screenWidth * 0.06,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.01),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 215,
                  width: screenWidth * 0.99,
                  child: Image.asset(
                    image,
                    //width: double.infinity,
                    height: screenHeight * 0.22,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
