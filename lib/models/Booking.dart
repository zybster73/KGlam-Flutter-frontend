import 'package:flutter/material.dart';

class Booking {
  final int id;
  final String name;
  final String salonName;
  final String serviceName;
  final String bookingDate;
  final String bookingTime;
  final String Status;

  Booking({
    required this.id,
    required this.name,
    required this.salonName,
    required this.serviceName,
    required this.bookingDate,
    required this.bookingTime,
    required this.Status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      name: json['customer_name'],
      salonName: json['salon_name'],
      serviceName: json['service_name'],
      bookingDate: json['booking_date'],
      bookingTime: json['booking_time'],
      Status: json['status'],
    );
  }
}
