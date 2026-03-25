import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _isLoading = false;
  bool _agreeTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يجب قبول الشروط والأحكام'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () async {
        if (!mounted) return;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('has_seen_onboarding', true);
        await prefs.setBool('has_completed_registration', true);

        setState(() {
          _isLoading = false;
        });

        if (!mounted) return;

        // Returning users should land directly on client home.
        Navigator.of(context).pushReplacementNamed('/client/home');
      });
    }
  }

  void _goToLoginScreen() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData rightIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? leftWidget,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.darkText,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textDirection: TextDirection.rtl,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            suffixIcon: Container(
              width: 52,
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: AppColors.borderColor)),
              ),
              child: Icon(rightIcon, color: AppColors.greyText),
            ),
            prefixIcon: leftWidget,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 14),
                child: Center(
                  child: Text(
                    AppStrings.registerTitle,
                    style: const TextStyle(
                      color: AppColors.darkText,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.borderColor),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(
                          width: 122,
                          height: 122,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.10),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.medical_services,
                            color: AppColors.primary,
                            size: 50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'أهلاً بك في تطبيقنا الطبي',
                          style: const TextStyle(
                            color: AppColors.darkText,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.25,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                          'يرجى ملء البيانات التالية لإنشاء حسابك الطبي الخاص\nوالاستفادة من خدماتنا',
                          style: TextStyle(
                            color: AppColors.lightText,
                            fontSize: 14,
                            height: 1.5,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Full Name Field
                      _buildInputField(
                        label: AppStrings.fullName,
                        hint: 'أدخل اسمك الكامل',
                        controller: _nameController,
                        rightIcon: Icons.person,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'الاسم مطلوب';
                          }
                          if (value!.length < 3) {
                            return 'الاسم يجب أن يكون 3 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Phone Field
                      _buildInputField(
                        label: AppStrings.phoneNumber,
                        hint: '20XXXXXXXX',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        rightIcon: Icons.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'رقم الهاتف مطلوب';
                          }
                          if (value!.length < 10) {
                            return 'رقم الهاتف غير صحيح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Password Field
                      _buildInputField(
                        label: AppStrings.password,
                        hint: 'أدخل كلمة المرور',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        rightIcon: Icons.lock,
                        leftWidget: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.greyText,
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'كلمة المرور مطلوبة';
                          }
                          if (value!.length < 6) {
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Confirm Password Field
                      _buildInputField(
                        label: AppStrings.confirmPassword,
                        hint: '........',
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        rightIcon: Icons.history,
                        leftWidget: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.greyText,
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'تأكيد كلمة المرور مطلوب';
                          }
                          if (value != _passwordController.text) {
                            return 'كلمات المرور غير متطابقة';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Terms and Conditions Checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'أوافق على ',
                                    style: TextStyle(
                                      color: AppColors.darkText,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'الشروط والأحكام',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' و ',
                                    style: TextStyle(
                                      color: AppColors.darkText,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'سياسة الخصوصية',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _agreeTerms = !_agreeTerms;
                              });
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _agreeTerms
                                    ? AppColors.primary
                                    : AppColors.white,
                                border: Border.all(
                                  color: AppColors.borderColor,
                                ),
                              ),
                              child: _agreeTerms
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: AppColors.white,
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Register Button
                      SizedBox(
                        height: 58,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 10,
                            shadowColor: AppColors.primary.withValues(
                              alpha: 0.28,
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  AppStrings.register,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      // Login Link
                      Center(
                        child: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: AppStrings.haveAccount,
                                style: TextStyle(
                                  color: AppColors.lightText,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: AppStrings.signIn,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _goToLoginScreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(height: 1, color: AppColors.borderColor),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'تحتاج مساعدة؟ اتصل بالدعم الفني',
                    style: TextStyle(
                      color: AppColors.lightText.withValues(alpha: 0.8),
                      fontSize: 14,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
