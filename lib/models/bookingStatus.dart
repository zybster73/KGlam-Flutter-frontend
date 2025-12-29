class Bookingstatus {
  final int bookingId;
  final String serviceName;
  final String customer;
  final String status;

  Bookingstatus({
    required this.bookingId,
    required this.serviceName,
    required this.customer,
    required this.status,
  });

  factory Bookingstatus.fromJson(Map<String, dynamic> json) {
    return Bookingstatus(
      bookingId: json['booking_id'],
      serviceName: json['service_name'],
      customer: json['customer'],
      status: json['status'],
    );
  }
}
