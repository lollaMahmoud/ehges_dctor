import 'package:flutter/material.dart';
import 'doctor_schedule_screen.dart';
import '../widgets/doctor_bottom_nav.dart';

class DoctorAppointmentDetailsScreen extends StatefulWidget {
  final Map<String, String> appointment;

  const DoctorAppointmentDetailsScreen({
    super.key,
    required this.appointment,
  });

  @override
  State<DoctorAppointmentDetailsScreen> createState() =>
      _DoctorAppointmentDetailsScreenState();
}

class _DoctorAppointmentDetailsScreenState
    extends State<DoctorAppointmentDetailsScreen> {
  String _status = 'انتظار';
  late Map<String, String> _appointmentData;
  late String _appointmentDate;
  late String _appointmentTime;

  @override
  void initState() {
    super.initState();
    _appointmentData = widget.appointment.isNotEmpty 
        ? Map<String, String>.from(widget.appointment)
        : {
            'name': 'ياسين خالد',
            'phone': '0123456789',
            'age': '28 سنة',
            'blood': '+A',
            'date': 'اليوم، 15 أكتوبر 2023',
            'time': '02:30 مساءً',
          };
    _appointmentDate = _appointmentData['date'] ?? 'اليوم، 15 أكتوبر 2023';
    _appointmentTime = _appointmentData['time'] ?? '02:30 مساءً';
  }

  int _extractSelectedDay() {
    final match = RegExp(r'(\d+)').firstMatch(_appointmentDate);
    return int.tryParse(match?.group(1) ?? '') ?? 5;
  }

  Future<void> _pickNewAppointment() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => DoctorScheduleScreen(
          selectionMode: true,
          initialDay: _extractSelectedDay(),
        ),
      ),
    );

    if (result == null) return;

    setState(() {
      _appointmentDate = result['date'] ?? _appointmentDate;
      _appointmentTime = result['time'] ?? _appointmentTime;
      _appointmentData['date'] = _appointmentDate;
      _appointmentData['time'] = _appointmentTime;
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
          'تفاصيل الحجز',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 52,
                      backgroundColor: Color(0xFFE8F6FF),
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 48, color: Color(0xFF94A3B8)),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E),
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _appointmentData['name'] ?? 'ياسين خالد',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '0123456789',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    _chip('العمر: 28 سنة'),
                    _chip('فصيلة الدم: +A'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'معلومات الموعد',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickNewAppointment,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    //child: Icon(Icons.edit_calendar, color: Color(0xFF1D9BF0), size: 20),
                  ),
                  const SizedBox(height: 6),
                  _InfoRow(icon: Icons.calendar_month, title: 'تاريخ الحجز', value: _appointmentDate),
                  const SizedBox(height: 12),
                  _InfoRow(icon: Icons.access_time_filled, title: 'وقت الحجز المتوقع', value: _appointmentTime),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'الأعراض والملاحظات',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: const Border(
                right: BorderSide(color: Color(0xFF1D9BF0), width: 4),
              ),
            ),
            child: const Text(
              'يعاني المريض من آلام حادة في الظهر بدأت منذ ثلاثة أيام، تزداد عند الجلوس لفترات طويلة، مع شعور بالتنميل في القدم اليسرى. لا يوجد تاريخ مرضي لإصابات سابقة.',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                height: 1.7,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'تحديث حالة الموعد',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _statusButton('ملغي', Icons.cancel, _status == 'ملغي')),
              const SizedBox(width: 10),
              Expanded(child: _statusButton('مكتمل', Icons.check_circle, _status == 'مكتمل')),
              const SizedBox(width: 10),
              Expanded(child: _statusButton('انتظار', Icons.hourglass_bottom, _status == 'انتظار')),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ التغييرات بنجاح')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D9BF0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
              child: const Text(
                'حفظ التغييرات',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        ),
      ),
      bottomNavigationBar: doctorBottomBar(context, 2),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F4FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF0369A1), fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _statusButton(String value, IconData icon, bool selected) {
    return GestureDetector(
      onTap: () => setState(() => _status = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.white : const Color(0xFFEEF2F7),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? const Color(0xFF1D9BF0) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? const Color(0xFF1D9BF0) : const Color(0xFF64748B)),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: selected ? const Color(0xFF1D9BF0) : const Color(0xFF475569),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFFE7F4FF),
          child: Icon(icon, color: const Color(0xFF1D9BF0)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              Text(
                title,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
