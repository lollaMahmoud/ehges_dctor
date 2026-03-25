import 'package:flutter/material.dart';
import '../widgets/doctor_bottom_nav.dart';
import '../schedule/doctor_appointment_details_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  String _filter = 'الكل';

  final List<Map<String, String>> _todayAppointments = [
    {
      'name': 'سارة علي',
      'time': '10:30 صباحاً',
      'status': 'قيد الانتظار',
      'action': 'عرض الملف',
    },
    {
      'name': 'محمد عبدالله',
      'time': '11:15 صباحاً',
      'status': 'مكتمل',
      'action': 'عرض التقرير',
    },
    {
      'name': 'فاطمة عمر',
      'time': '01:00 مساءً',
      'status': 'قيد الانتظار',
      'action': 'عرض الملف',
    },
    {
      'name': 'ياسين خالد',
      'time': '02:30 مساءً',
      'status': 'قادم',
      'action': 'عرض الملف',
    },
  ];

  List<Map<String, String>> get _filtered {
    if (_filter == 'الكل') return _todayAppointments;
    return _todayAppointments.where((item) => item['status'] == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // start: معلومات الدكتور + الأفاتار
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/doctor/professional-info');
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFE2F1FF),
                      child: Icon(Icons.person, color: Color(0xFF0EA5E9)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'مرحباً دكتور،',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'أحمد محمد',
                        style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // end: أيقونة الإشعارات
              IconButton(
                icon: const Icon(Icons.notifications, color: Color(0xFF334155), size: 26),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorAppointmentDetailsScreen(
                        appointment: {
                          'name': 'ياسين خالد',
                          'phone': '0123456789',
                          'age': '28 سنة',
                          'blood': '+A',
                          'date': 'اليوم، 15 أكتوبر 2023',
                          'time': '02:30 مساءً',
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'احجز دكتورك',
                style: TextStyle(
                  color: Color(0xFF2196F3),
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  title: 'مواعيد اليوم',
                  value: '12',
                  tint: const Color(0xFFF1F6FE),
                  valueColor: const Color(0xFF2196F3),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  title: 'تم إنجازها',
                  value: '8',
                  tint: const Color(0xFFE9F8F1),
                  valueColor: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'مواعيد اليوم',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _filterButton('الكل')),
              const SizedBox(width: 10),
              Expanded(child: _filterButton('قيد الانتظار')),
              const SizedBox(width: 10),
              Expanded(child: _filterButton('مكتمل')),
            ],
          ),
          const SizedBox(height: 14),
          ..._filtered.map((item) => _appointmentCard(item)),
          const SizedBox(height: 14),
        ],
      ),
      ),
      bottomNavigationBar: doctorBottomBar(context, 3),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required Color tint,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFDCEAF7)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),


            Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(String label) {
    final selected = _filter == label;
    return GestureDetector(
      onTap: () => setState(() => _filter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1D9BF0) : const Color(0xFFECF1F7),
          borderRadius: BorderRadius.circular(40),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1D9BF0).withValues(alpha: 0.24),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF475569),
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  Widget _appointmentCard(Map<String, String> item) {
    final status = item['status']!;
    Color statusBg;
    Color statusColor;
    if (status == 'مكتمل') {
      statusBg = const Color(0xFFDDFBE9);
      statusColor = const Color(0xFF16A34A);
    } else if (status == 'قيد الانتظار') {
      statusBg = const Color(0xFFFEF6D8);
      statusColor = const Color(0xFFCA8A04);
    } else {
      statusBg = const Color(0xFFEFF3F8);
      statusColor = const Color(0xFF94A3B8);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEDF2F7)),
      ),
      child: Row(
        children: [
          // يمين: أفاتار + اسم + وقت
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFF0E7490),
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.access_time_filled, size: 14, color: Color(0xFF64748B)),
                    const SizedBox(width: 4),
                    Text(
                      item['time']!,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // يسار: حالة + عرض الملف
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/doctor/appointment-details',
                  arguments: item,
                ),
                child: const Text(
                  'عرض الملف',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

