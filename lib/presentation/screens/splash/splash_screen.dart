import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const Duration _splashDuration = Duration(seconds: 3);
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: _splashDuration,
    )..forward();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
    final hasCompletedRegistration =
        prefs.getBool('has_completed_registration') ?? false;

    Future.delayed(_splashDuration, () {
      if (mounted) {
        if (hasCompletedRegistration) {
          Navigator.of(context).pushReplacementNamed('/client/home');
        } else if (hasSeenOnboarding) {
          Navigator.of(context).pushReplacementNamed('/register');
        } else {
          Navigator.of(context).pushReplacementNamed('/onboarding');
        }
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              // Medical Kit Icon
              Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withValues(alpha: 0.08),
                      blurRadius: 18,
                      spreadRadius: 1,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.medical_services,
                    size: 120,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Title
              Text(
                AppStrings.splashTitle,
                style: const TextStyle(
                  color: AppColors.darkText,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 12),
              // Subtitle
              Text(
                AppStrings.splashSubtitle,
                style: const TextStyle(
                  color: AppColors.lightText,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              const Spacer(),
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  final int progressPercent = (_progressController.value * 100)
                      .clamp(0, 100)
                      .round();

                  return Column(
                    children: [
                      // Loading status row
                      SizedBox(
                        width: 300,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            children: [
                              Text(
                                '$progressPercent%',
                                style: const TextStyle(
                                  color: AppColors.greyText,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                AppStrings.loading,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: _progressController.value,
                            minHeight: 10,
                            backgroundColor: AppColors.borderColor,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
