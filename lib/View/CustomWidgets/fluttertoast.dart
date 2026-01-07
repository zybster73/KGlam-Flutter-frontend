import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  Utils._privateConstructor();
  static final Utils instance = Utils._privateConstructor();

  FToast? _fToast;

  // Initialize only ONCE per screen
  void initToast(BuildContext context) {
    _fToast ??= FToast();
    _fToast!.init(context);
  }

  void toastMessage(String message) {
    if (_fToast == null) return; // prevents context errors

    final toast = Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Color.fromARGB(255, 167, 226, 226),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, color: Colors.black),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    Future.microtask(() {
      _fToast?.showToast(

        child: toast,
        fadeDuration: Duration(milliseconds: 500),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 3),
      );
    });
  }
}
