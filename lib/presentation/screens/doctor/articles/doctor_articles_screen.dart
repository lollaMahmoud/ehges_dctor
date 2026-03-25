import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_drawing/path_drawing.dart';
import '../widgets/doctor_bottom_nav.dart';

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final path = Path()..addRRect(rRect);
    
    // استخدم dashPath من path_drawing - أسهل بكثير!
    final dashedPath = dashPath(
      path,
      dashArray: CircularIntervalList<double>([8.0, 4.0]),
    );
    
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DoctorArticlesScreen extends StatefulWidget {
  const DoctorArticlesScreen({super.key});

  @override
  State<DoctorArticlesScreen> createState() => _DoctorArticlesScreenState();
}

class _DoctorArticlesScreenState extends State<DoctorArticlesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String _category = '';
  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم اختيار الصورة بنجاح')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ في اختيار الصورة')),
        );
      }
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
          'نشر مقال طبي جديد',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: Color(0xFF166534),
              child: Icon(Icons.grass, color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text('صورة الغلاف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _pickImageFromGallery,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // الصورة أو المحتوى
                  if (_selectedImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  if (_selectedImage == null)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_a_photo, color: Color(0xFF2196F3), size: 46),
                          const SizedBox(height: 10),
                          const Text(
                            'اضغط لتحميل صورة المقال',
                            style: TextStyle(
                              color: Color(0xFF0EA5E9),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'يدعم JPG, PNG (حد أقصى 5 ميجابايت)',
                            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  // الحافة المنقطة
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _DashedBorderPainter(
                        color: const Color(0xFFB3E2FF),
                        strokeWidth: 2,
                        radius: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _label('عنوان المقال'),
          _field(_titleController, 'مثلاً: أهمية الفحص الدوري للسكري'),
          const SizedBox(height: 12),
          _label('الفئة الطبية'),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7FF),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: const Color(0xFFD3EAFE)),
            ),
            child: DropdownButtonFormField<String>(
              initialValue: _category.isEmpty ? null : _category,
              decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
              alignment: Alignment.centerRight,
              hint: const Text('اختر الفئة', textAlign: TextAlign.right),
              items: const [
                DropdownMenuItem(value: 'الصحة العامة', child: Text('الصحة العامة')),
                DropdownMenuItem(value: 'التغذية', child: Text('التغذية')),
                DropdownMenuItem(value: 'الطب الوقائي', child: Text('الطب الوقائي')),
              ],
              onChanged: (value) => setState(() => _category = value ?? ''),
            ),
          ),
          const SizedBox(height: 12),
          _label('محتوى المقال'),
          _field(_contentController, 'اكتب تفاصيل مقالك الطبي هنا بالتفصيل...', maxLines: 7),
          const SizedBox(height: 18),
          SizedBox(
            height: 58,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('ضع عنوانا للمقال'),
                      backgroundColor: Color(0xFFEF4444),
                    ),
                  );
                  return;
                }
                if (_contentController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('اكتب محتوى المقال'),
                      backgroundColor: Color(0xFFEF4444),
                    ),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم نشر المقال بنجاح'),
                    backgroundColor: Color(0xFF22C55E),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D9BF0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              ),
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text(
                'نشر المقال الآن',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: doctorBottomBar(context, 1),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _field(TextEditingController controller, String hint, {int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const Color(0xFFD3EAFE)),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
