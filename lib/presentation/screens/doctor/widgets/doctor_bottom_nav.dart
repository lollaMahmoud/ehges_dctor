import 'package:flutter/material.dart';
import '../schedule/doctor_appointment_details_screen.dart';

Widget doctorBottomBar(BuildContext context, int index) {
  return BottomNavigationBar(
    currentIndex: index,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: const Color(0xFF1D9BF0),
    unselectedItemColor: const Color(0xFF94A3B8),
    backgroundColor: Colors.white,
    onTap: (value) {
      if (value == index) return;
      if (value == 0) {
        Navigator.pushReplacementNamed(context, '/doctor/professional-info');
      } else if (value == 1) {
        Navigator.pushReplacementNamed(context, '/doctor/articles');
      } else if (value == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DoctorAppointmentDetailsScreen(
              appointment: {
                'name': 'ياسين خالد',
                'time': '02:30 مساءً',
                'date': 'اليوم، 15 أكتوبر 2023',
                'status': 'انتظار',
                'action': 'عرض الملف',
              },
            ),
          ),
        );
      } else if (value == 3) {
        Navigator.pushReplacementNamed(context, '/doctor/home');
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: 'المقالات'),
      BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'الجدول'),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'المواعيد'),
    ],
  );
}
