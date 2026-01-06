class CompleteBookingModel {
  final String message;
  final int bookingId;
  final String status;

  CompleteBookingModel({
    required this.message,
    required this.bookingId,
    required this.status,
  });

  factory CompleteBookingModel.fromJson(Map<String, dynamic> json) {
    return CompleteBookingModel(
      message: json['msg'],
      bookingId: json['booking_id'],
      status: json['status'],
    );
  }
}
