import 'package:flutter/material.dart';
import '../widgets/doctor_bottom_nav.dart';

class DoctorProfessionalInfoEditScreen extends StatefulWidget {
  const DoctorProfessionalInfoEditScreen({super.key});

  @override
  State<DoctorProfessionalInfoEditScreen> createState() => _DoctorProfessionalInfoEditScreenState();
}

class _DoctorProfessionalInfoEditScreenState extends State<DoctorProfessionalInfoEditScreen> {
  final _jobController = TextEditingController();
  final _yearsController = TextEditingController();
  final _clinicController = TextEditingController();
  final _bioController = TextEditingController();
  final _serviceController = TextEditingController();

  String _specialty = '';
  final List<String> _services = ['كشف منزلي', 'استشارة أونلاين'];

  double _progressValue = 0.0;

  double get progressValue {
    int filledFields = 0;
    if (_specialty.isNotEmpty) filledFields++;
    if (_jobController.text.trim().isNotEmpty) filledFields++;
    if (_yearsController.text.trim().isNotEmpty) filledFields++;
    if (_clinicController.text.trim().isNotEmpty) filledFields++;
    if (_bioController.text.trim().isNotEmpty) filledFields++;
    return filledFields / 5.0;
  }

  @override
  void initState() {
    super.initState();
    _jobController.addListener(_updateProgress);
    _yearsController.addListener(_updateProgress);
    _clinicController.addListener(_updateProgress);
    _bioController.addListener(_updateProgress);
    _serviceController.addListener(_updateProgress);
    _updateProgress(); // Initialize progress
  }

  void _updateProgress() {
    setState(() {
      _progressValue = progressValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'المعلومات المهنية',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('${(_progressValue * 100).round()}%', style: const TextStyle(color: Color(0xFF64748B), fontSize: 16)),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _progressValue,
              minHeight: 8,
              backgroundColor: const Color(0xFFE2E8F0),
              color: const Color(0xFF1D9BF0),
            ),
          ),
          const SizedBox(height: 6),
          const Align(
            alignment: Alignment.centerRight,
            child: Text('إكمال الملف الشخصي', style: TextStyle(color: Color(0xFF0369A1), fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'تفاصيل المهنة',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 12),
          _label('التخصص'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonFormField<String>(
              initialValue: _specialty.isEmpty ? null : _specialty,
              decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 8)),
              hint: const Text('اختر التخصص', textAlign: TextAlign.right),
              items: const [
                DropdownMenuItem(value: 'جراحة العظام', child: Text('جراحة العظام')),
                DropdownMenuItem(value: 'باطنة', child: Text('باطنة')),
                DropdownMenuItem(value: 'جلدية', child: Text('جلدية')),
              ],
              onChanged: (v) {
                setState(() {
                  _specialty = v ?? '';
                  _updateProgress();
                });
              },
            ),
          ),
          _label('المسمى الوظيفي'),
          _field(_jobController, 'مثلاً: استشاري جراحة العظام'),
          _label('سنوات الخبرة'),
          _field(_yearsController, 'سنوات'),
          _label('عنوان العيادة'),
          _field(_clinicController, 'المدينة، الشارع، البناية', icon: Icons.location_on),
          _label('نبذة تعريفية'),
          _field(_bioController, 'اكتب نبذة مختصرة عن مسيرتك المهنية وإنجازاتك...', maxLines: 4),
          _label('الخدمات المقدمة'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: _services
                .map(
                  (service) => Chip(
                    label: Text(service, style: const TextStyle(color: Color(0xFF0369A1), fontWeight: FontWeight.w700)),
                    backgroundColor: const Color(0xFFE7F4FF),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => setState(() => _services.remove(service)),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFF1D9BF0),
                child: IconButton(
                  onPressed: () {
                    if (_serviceController.text.trim().isNotEmpty) {
                      setState(() {
                        _services.add(_serviceController.text.trim());
                        _serviceController.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: _field(_serviceController, 'أضف خدمة جديدة...')),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // جمع البيانات المهنية
                final professionalData = {
                  'specialty': _specialty,
                  'jobTitle': _jobController.text.trim(),
                  'yearsOfExperience': _yearsController.text.trim(),
                  'clinicAddress': _clinicController.text.trim(),
                  'bio': _bioController.text.trim(),
                  'services': List<String>.from(_services),
                };

                // العودة بالبيانات
                Navigator.pop(context, professionalData);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ التعديلات المهنية')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D9BF0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                'حفظ التعديلات',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
          ),
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

  Widget _field(TextEditingController controller, String hint, {int maxLines = 1, IconData? icon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          suffixIcon: icon == null ? null : Icon(icon, color: const Color(0xFF1D9BF0)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _jobController.removeListener(_updateProgress);
    _yearsController.removeListener(_updateProgress);
    _clinicController.removeListener(_updateProgress);
    _bioController.removeListener(_updateProgress);
    _serviceController.removeListener(_updateProgress);
    _jobController.dispose();
    _yearsController.dispose();
    _clinicController.dispose();
    _bioController.dispose();
    _serviceController.dispose();
    super.dispose();
  }
}
