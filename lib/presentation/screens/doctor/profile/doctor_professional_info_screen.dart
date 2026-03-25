import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/doctor_bottom_nav.dart';

class DoctorProfessionalInfoScreen extends StatefulWidget {
  const DoctorProfessionalInfoScreen({super.key});

  @override
  State<DoctorProfessionalInfoScreen> createState() => _DoctorProfessionalInfoScreenState();
}

class _DoctorProfessionalInfoScreenState extends State<DoctorProfessionalInfoScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  String _name = 'د. عصام الخالدي';
  String _phone = '+966 50 123 4567';
  String _email = 'dr.ahmed@ehjiz.com';
  String _birth = '05/15/1985';

  // البيانات المهنية
  String _specialty = '';
  String _jobTitle = 'استشاري جراحة القلب والأوعية الدموية';
  String _yearsOfExperience = '';
  String _clinicAddress = 'مركز المدينة الطبي، الطابق الرابع';
  String _bio = 'خبرة أكثر من 20 عاماً في جراحة القلب المفتوح والقسطرة التداخلية. حاصل على البورد الأمريكي وزمالة كلية الجراحين الملكية. مكرس لتقديم أفضل رعاية طبية لمرضاي.';
  List<String> _services = ['كشف منزلي', 'استشارة أونلاين'];

  String get _fullBio {
    List<String> parts = [];
    if (_specialty.isNotEmpty) parts.add('تخصص: $_specialty');
    if (_jobTitle.isNotEmpty) parts.add('المسمى الوظيفي: $_jobTitle');
    if (_yearsOfExperience.isNotEmpty) parts.add('سنوات الخبرة: $_yearsOfExperience');
    if (_clinicAddress.isNotEmpty) parts.add('عنوان العيادة: $_clinicAddress');
    if (_bio.isNotEmpty) parts.add('النبذة: $_bio');
    return parts.isNotEmpty ? parts.join('\n\n') : 'خبرة أكثر من 20 عاماً في جراحة القلب المفتوح والقسطرة التداخلية. حاصل على البورد الأمريكي وزمالة كلية الجراحين الملكية. مكرس لتقديم أفضل رعاية طبية لمرضاي.';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      setState(() {
        _name = args['name'] ?? _name;
        _phone = args['phone'] ?? _phone;
        _email = args['email'] ?? _email;
        _birth = args['birth'] ?? _birth;
        _profileImage = args['image'] as File?;

        // البيانات المهنية
        _specialty = args['specialty'] ?? _specialty;
        _jobTitle = args['jobTitle'] ?? _jobTitle;
        _yearsOfExperience = args['yearsOfExperience'] ?? _yearsOfExperience;
        _clinicAddress = args['clinicAddress'] ?? _clinicAddress;
        _bio = args['bio'] ?? _bio;
        _services = args['services'] != null ? List<String>.from(args['services']) : _services;
      });
    }
  }

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
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F4F6),
        elevation: 0,
        title: const Text(
          'صفحتك الشخصية',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1D9BF0)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF0F172A)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 148,
                    height: 148,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFDCF1FF),
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(_profileImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 100, color: Color(0xFF0F172A))
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1D9BF0),
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                _name,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                'استشاري جراحة القلب والأوعية الدموية',
                style: TextStyle(fontSize: 16, color: Color(0xFF1D9BF0)),
              ),
            ),
            const SizedBox(height: 6),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFF1D9BF0)),
                      SizedBox(width: 8),
                      Text('النبذة التعريفية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _fullBio,
                    style: TextStyle(fontSize: 16, color: Color(0xFF52606D)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Icon(Icons.phone, color: Color(0xFF1D9BF0)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('الهاتف', style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
                            Text(_phone, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Icon(Icons.email, color: Color(0xFF1D9BF0)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('البريد الإلكتروني', style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
                            Text(_email, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Icon(Icons.calendar_today, color: Color(0xFF1D9BF0)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('تاريخ الميلاد', style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
                            Text(_birth, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildOptionItem(
              context,
              title: 'تعديل الملف الشخصي',
              icon: Icons.person,
              onTap: () => Navigator.pushNamed(context, '/doctor/profile-edit'),
              color: const Color(0xFF0EA5E9),
            ),
            const SizedBox(height: 12),
            _buildOptionItem(
              context,
              title: 'المعلومات المهنية',
              icon: Icons.badge,
              onTap: () async {
                final result = await Navigator.pushNamed(context, '/doctor/professional-info-edit');
                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    _specialty = result['specialty'] ?? _specialty;
                    _jobTitle = result['jobTitle'] ?? _jobTitle;
                    _yearsOfExperience = result['yearsOfExperience'] ?? _yearsOfExperience;
                    _clinicAddress = result['clinicAddress'] ?? _clinicAddress;
                    _bio = result['bio'] ?? _bio;
                    _services = result['services'] != null ? List<String>.from(result['services']) : _services;
                  });
                }
              },
              color: const Color(0xFF0EA5E9),
            ),
            const SizedBox(height: 12),
            _buildOptionItem(
              context,
              title: 'إعدادات التطبيق',
              icon: Icons.settings,
              onTap: () {},
              color: const Color(0xFF3B82F6),
            ),
            const SizedBox(height: 12),
            _buildOptionItem(
              context,
              title: 'تسجيل الخروج',
              icon: Icons.logout,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('تسجيل الخروج'),
                    content: const Text('هل تريد الخروج من التطبيق؟'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        },
                        child: const Text('خروج'),
                      ),
                    ],
                  ),
                );
              },
              color: const Color(0xFFEF4444),
            ),
          ],
        ),
      ),
      bottomNavigationBar: doctorBottomBar(context, 0),
    );
  }

  Widget _buildOptionItem(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap,
      required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color),
              ),
            ),
            Icon(Icons.arrow_back_ios, color: Color(0xFF1D9BF0), size: 20),
          ],
        ),
      ),
    );
  }
}

