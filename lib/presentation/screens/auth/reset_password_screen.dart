import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitReset() {
    if (!_formKey.currentState!.validate()) return;

    setState(() { _isLoading = true; });
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() { _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'استعادة كلمة المرور',
          style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'أدخل رقم هاتفك لاستلام رمز التحقق ومن ثم ضع كلمة مرور جديدة',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: AppColors.lightText, fontSize: 15),
                ),
                const SizedBox(height: 20),

                _buildField(
                  label: AppStrings.phoneNumber,
                  hint: '20XXXXXXXX',
                  controller: _phoneController,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) return 'رقم الهاتف مطلوب';
                    if (value!.trim().length < 10) return 'رقم الهاتف غير صحيح';
                    return null;
                  },
                  icon: Icons.phone,
                ),
                const SizedBox(height: 12),

                _buildField(
                  label: 'كلمة المرور الجديدة',
                  hint: 'أدخل كلمة مرور جديدة',
                  controller: _newPasswordController,
                  obscureText: _obscurePassword,
                  icon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                      color: AppColors.greyText,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) return 'كلمة المرور مطلوبة';
                    if (value!.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                _buildField(
                  label: AppStrings.confirmPassword,
                  hint: 'أكد كلمة المرور',
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  icon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                      color: AppColors.greyText,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) return 'تأكيد كلمة المرور مطلوب';
                    if (value != _newPasswordController.text) return 'كلمتا المرور غير متطابقتين';
                    return null;
                  },
                ),
                const SizedBox(height: 26),

                SizedBox(
                  height: 58,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitReset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: AppColors.white)
                        : const Text(
                            'إعادة تعيين كلمة المرور',
                            style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
    IconData? icon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.darkText, fontSize: 12, fontWeight: FontWeight.w700),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            suffixIcon: suffixIcon,
            prefixIcon: icon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(icon, color: AppColors.greyText),
                  ),
          ),
        ),
      ],
    );
  }
}
