class CustomerBooking {
  final int id;
  final String serviceName;
  final String servicePrice;
  final String salonName;
  final String salonAddress;
  final String bookingDate;
  final String bookingTime;
  final String status;
  final String? image;
  final int? feedbackId;

  CustomerBooking({
    required this.id,
    required this.serviceName,
    required this.servicePrice,
    required this.salonName,
    required this.salonAddress,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    this.image,
     this.feedbackId,
  });

  factory CustomerBooking.fromJson(Map<String, dynamic> json) {
    return CustomerBooking(
      id: json['id'],
      serviceName: json['service_name'],
      servicePrice: json['service_price'],
      salonName: json['salon_name'],
      salonAddress: json['salon_address'],
      bookingDate: json['booking_date'],
      bookingTime: json['booking_time'],
      status: json['status'],
      image: json['service_image'],
      feedbackId: json['feedback_id']
    );
  }
}
