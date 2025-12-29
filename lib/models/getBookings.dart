class getBookings {
  final int id;
  final String customerName;
  final String serviceName;
  final String bookingDate;
  final String bookingTime;
  final String Status;

  getBookings({
    required this.id,
    required this.customerName,
    required this.serviceName,
    required this.bookingDate,
    required this.bookingTime,
    required this.Status,
  });
  factory getBookings.fromJson(Map<String, dynamic> json) {
    return getBookings(
      id: json['id'],
      customerName: json['customer_name'],
      serviceName: json['service_name'],
      bookingDate: json['booking_date'],
      bookingTime: json['booking_time'],
      Status: json['status'],
    );
  }
}
