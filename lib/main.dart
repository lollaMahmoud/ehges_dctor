import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'presentation/models/doctor_model.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';
import 'presentation/screens/client/home/client_home_screen.dart';
import 'presentation/screens/client/doctors_list/doctors_list_screen.dart';
import 'presentation/screens/client/doctor_details/doctor_details_screen.dart';
import 'presentation/screens/client/book_appointment/book_appointment_screen.dart';
import 'presentation/screens/client/book_appointment/appointment_confirmation_screen.dart';
import 'presentation/screens/client/appointments/appointments_screen.dart';
import 'presentation/screens/client/articles/article_details_screen.dart';
import 'presentation/screens/client/articles/articles_screen.dart';
import 'presentation/screens/client/profile/profile_screen.dart';
import 'presentation/screens/doctor/home/doctor_home_screen.dart';
import 'presentation/screens/doctor/schedule/doctor_appointment_details_screen.dart';
import 'presentation/screens/doctor/schedule/doctor_schedule_screen.dart';
import 'presentation/screens/doctor/articles/doctor_articles_screen.dart';
import 'presentation/screens/doctor/profile/doctor_profile_edit_screen.dart';
import 'presentation/screens/doctor/profile/doctor_professional_info_screen.dart';
import 'presentation/screens/doctor/profile/doctor_professional_info_edit_screen.dart';
import 'presentation/screens/auth/reset_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'احجز دكتورك',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const ClientHomeScreen(),
        '/client/home': (context) => const ClientHomeScreen(),
        '/doctors_list': (context) => const DoctorsListScreen(),
        '/appointments': (context) => const AppointmentsScreen(),
        '/articles': (context) => const ArticlesScreen(),
        '/article_details': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return ArticleDetailsScreen(article: args);
        },
        '/profile': (context) => const ProfileScreen(),
        '/doctor/home': (context) => const DoctorHomeScreen(),
        '/doctor/schedule': (context) => const DoctorScheduleScreen(),
        '/doctor/articles': (context) => const DoctorArticlesScreen(),
        '/doctor/profile-edit': (context) => const DoctorProfileEditScreen(),
        '/doctor/professional-info': (context) =>
            const DoctorProfessionalInfoScreen(),
        '/doctor/professional-info-edit': (context) =>
            const DoctorProfessionalInfoEditScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/doctor_details') {
          final doctor = settings.arguments as Doctor;
          return MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(doctor: doctor),
          );
        }
        if (settings.name == '/book_appointment') {
          final doctor = settings.arguments as Doctor;
          return MaterialPageRoute(
            builder: (context) => BookAppointmentScreen(doctor: doctor),
          );
        }
        if (settings.name == '/appointment_confirmation') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => AppointmentConfirmationScreen(
              doctor: args['doctor'] as Doctor,
              name: args['name'] as String,
              phone: args['phone'] as String,
              age: args['age'] as String,
              governorate: args['governorate'] as String,
              date: args['date'] as String,
              time: args['time'] as String,
              symptoms: args['symptoms'] as String,
            ),
          );
        }
        if (settings.name == '/doctor/appointment-details') {
          final data = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) =>
                DoctorAppointmentDetailsScreen(appointment: data),
          );
        }
        return null;
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      debugShowCheckedModeBanner: false,
    );
  }
}
