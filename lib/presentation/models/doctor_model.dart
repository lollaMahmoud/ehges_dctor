class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String specialtyAr;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String location;
  final String address;
  final int consultationFee;
  final String description;
  final int experienceYears;
  final List<String> services;
  final List<Review> reviews;
  final bool isAvailable;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.specialtyAr,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.location,
    required this.address,
    required this.consultationFee,
    required this.description,
    required this.experienceYears,
    required this.services,
    required this.reviews,
    required this.isAvailable,
  });
}

class Review {
  final String reviewerName;
  final double rating;
  final String comment;
  final String reviewerInitial;

  Review({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.reviewerInitial,
  });
}
