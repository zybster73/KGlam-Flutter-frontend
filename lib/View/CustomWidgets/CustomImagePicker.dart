import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageCard extends StatefulWidget {
  final String title;
  
  const UploadImageCard({
    super.key,
    required this.title, 
  });

  @override
  State<UploadImageCard> createState() => _UploadImageCardState();
}

class _UploadImageCardState extends State<UploadImageCard> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 160,
              width: double.infinity,
             // padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _selectedImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload,
                          color: const Color(0xFF01ABAB),
                          size: screenWidth * 0.08,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Upload your image in jpg, jpeg, or png format.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(12), 
                    child: Image.file(
                        _selectedImage!,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        
                      ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
