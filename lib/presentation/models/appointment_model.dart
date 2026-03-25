class Appointment {
  final String id;
  final String doctorName;
  final String specialty;
  final String specialtyAr;
  final String dateTime;
  final String status; // confirmed, pending, cancelled, completed
  final String location;
  final int consultationFee;
  final String doctorImage;

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.specialtyAr,
    required this.dateTime,
    required this.status,
    required this.location,
    required this.consultationFee,
    required this.doctorImage,
  });
}
