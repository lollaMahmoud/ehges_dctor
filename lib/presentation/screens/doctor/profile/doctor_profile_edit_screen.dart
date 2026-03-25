import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/doctor_bottom_nav.dart';

class DoctorProfileEditScreen extends StatefulWidget {
  const DoctorProfileEditScreen({super.key});

  @override
  State<DoctorProfileEditScreen> createState() => _DoctorProfileEditScreenState();
}

class _DoctorProfileEditScreenState extends State<DoctorProfileEditScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  final _nameController = TextEditingController(text: 'أحمد محمد العنزي');
  final _phoneController = TextEditingController(text: '+966 50 123 4567');
  final _emailController = TextEditingController(text: 'dr.ahmed@ehjiz.com');
  final _birthController = TextEditingController(text: '05/15/1985');

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      if (pickedFile == null) return;
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('حدث خطأ أثناء اختيار الصورة'),
        backgroundColor: Color(0xFFEF4444),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'تعديل الملف الشخصي',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: const Color(0xFFF5EFD9),
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(_profileImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 70, color: Color(0xFF0369A1))
                        : null,
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1D9BF0),
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('د. أحمد محمد', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              const Text('أخصائي جراحة عامة', style: TextStyle(color: Color(0xFF64748B), fontSize: 18)),
            ],
          ),
          const SizedBox(height: 20),
          _label('الاسم الكامل'),
          _field(_nameController, Icons.person),
          _label('رقم الهاتف'),
          _field(_phoneController, Icons.phone),
          _label('البريد الإلكتروني'),
          _field(_emailController, Icons.email),
          _label('تاريخ الميلاد'),
          _field(_birthController, Icons.calendar_month),
          const SizedBox(height: 16),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/doctor/professional-info',
                  arguments: {
                    'name': _nameController.text,
                    'phone': _phoneController.text,
                    'email': _emailController.text,
                    'birth': _birthController.text,
                    'image': _profileImage,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D9BF0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                'حفظ التغييرات',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: doctorBottomBar(context, 0),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ),
    );
  }

  Widget _field(TextEditingController controller, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          suffixIcon: Icon(icon, color: const Color(0xFF94A3B8)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthController.dispose();
    super.dispose();
  }
}
