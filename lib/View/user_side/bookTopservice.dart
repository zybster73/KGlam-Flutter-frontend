import 'package:KGlam/Services/clientApi.dart';
import 'package:KGlam/View/user_side/Selected_Date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Booktopservice extends StatefulWidget {
  final int serviceId;
  const Booktopservice({super.key, required this.serviceId});

  @override
  State<Booktopservice> createState() => _BooktopserviceState();
}

class _BooktopserviceState extends State<Booktopservice> {
  @override
  void initState() {
    super.initState();

    fetchService();
  }

  Map<String, dynamic>? specificService;

  Future<void> fetchService() async {
    final response = await client_Api().getspecificSalonClient(
      widget.serviceId,
    );

    setState(() {
      specificService = response;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Selected_Date(
                  imagePath: specificService!['service_image'],
                  
                  imageheight: 400,
                  //description: '',
                
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xFF01ABAB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Book Service",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.network(
              (specificService!['service_image']!= null && specificService!['service_image'].isNotEmpty)? 
              specificService!['service_image'] : const AssetImage('assets/images/unsplash.jpg') as ImageProvider,
            )
          ),

          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withOpacity(0.8),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 14,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

         
          Container(
            margin: EdgeInsets.only(top: 400 - 30),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    specificService!['service_name'],
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    specificService!['service_desc'],
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),

                  
                  SizedBox(height: 15.h),

                  Text(
                    specificService!['service_price'],
                    style: GoogleFonts.poppins(
                      color: Color(0xFF01ABAB),
                      fontSize: 24.sp,
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
}
