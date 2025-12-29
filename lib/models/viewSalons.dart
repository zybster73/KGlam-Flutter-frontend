class viewSalon {
  final int id;
  final String name;
  final String address;
  final String contact;
  final String hours;
  final String description;
  final String? profileImage;
  final String? coverImage;

  viewSalon({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.hours,
    required this.description,
    this.profileImage,
    this.coverImage,
  });

  factory viewSalon.fromJson(Map<String, dynamic> json) {
    return viewSalon(
      id: json['id'],
      name: json['salon_name'],
      address: json['salon_address'],
      contact: json['salon_contact'],
      hours: json['hours_of_operation'],
      description: json['salon_desc'],
      profileImage: json['salon_profile_image'],
      coverImage: json['salon_cover_image'],
    );
  }
}
