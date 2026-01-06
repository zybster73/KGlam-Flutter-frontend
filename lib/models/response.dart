import 'package:KGlam/models/Booking.dart';
import 'package:KGlam/models/bookingStatus.dart';

class Response {
  final bool success;
  final String message;
  final Booking? booking;
  final Bookingstatus? bookingstatus;
 

  Response({
    required this.success,
    required this.message,
    this.booking,
    this.bookingstatus,
  
  });
}
