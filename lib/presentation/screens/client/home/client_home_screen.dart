import 'package:flutter/material.dart';
import '../widgets/client_bottom_navigation_bar.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  List<Map<String, String>> doctors = [
    {
      'name': 'د. محمد علي',
      'specialty': 'استشاري عظام',
      'location': 'القاهرة',
      'fee': '300',
    },
    {
      'name': 'د. فاطمة أحمد',
      'specialty': 'استشاري نساء',
      'location': 'الإسكندرية',
      'fee': '250',
    },
    {
      'name': 'د. أحمد حسن',
      'specialty': 'استشاري قلب',
      'location': 'القاهرة',
      'fee': '400',
    },
    {
      'name': 'د. سارة محمد',
      'specialty': 'استشاري أطفال',
      'location': 'الجيزة',
      'fee': '200',
    },
  ];

  List<Map<String, String>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctors;
    _searchController.addListener(_filterDoctors);
    _specialtyController.addListener(_filterDoctors);
    _provinceController.addListener(_filterDoctors);
    _cityController.addListener(_filterDoctors);
  }

  void _filterDoctors() {
    setState(() {
      filteredDoctors = doctors.where((doctor) {
        final search = _searchController.text.toLowerCase();
        final specialty = _specialtyController.text.toLowerCase();
        final province = _provinceController.text.toLowerCase();
        final city = _cityController.text.toLowerCase();

        return (search.isEmpty ||
                doctor['name']!.toLowerCase().contains(search)) &&
            (specialty.isEmpty ||
                doctor['specialty']!.toLowerCase().contains(specialty)) &&
            (province.isEmpty ||
                doctor['location']!.toLowerCase().contains(province)) &&
            (city.isEmpty || doctor['location']!.toLowerCase().contains(city));
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _specialtyController.dispose();
    _provinceController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,
        title: const Text('احجز دكتورك', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: const Icon(Icons.notifications_none, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu, color: Colors.blue),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 201, 228, 248),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'ابحث عن أفضل الأطباء واحجز موعدك',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    buildTextField(
                      'ابحث عن طبيب أو عيادة...',
                      _searchController,
                    ),
                    const SizedBox(height: 10),
                    buildTextField('التخصص', _specialtyController),
                    const SizedBox(height: 10),
                    buildTextField('المحافظة', _provinceController),
                    const SizedBox(height: 10),
                    buildTextField('المدينة', _cityController),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ابحث الآن'),
                            SizedBox(width: 10),
                            Icon(Icons.search),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Specialties
              sectionTitle('التخصصات'),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    CategoryItem(icon: Icons.child_care, title: 'أطفال'),
                    CategoryItem(icon: Icons.hearing, title: 'أنف وأذن'),
                    CategoryItem(icon: Icons.medical_services, title: 'أسنان'),
                    CategoryItem(icon: Icons.psychology, title: 'نفسي'),
                    CategoryItem(icon: Icons.favorite, title: 'باطنة'),
                    CategoryItem(icon: Icons.female, title: 'نساء وتوليد'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Doctors
              sectionTitle('دكاترة مميزة'),
              const SizedBox(height: 10),

              SizedBox(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: filteredDoctors
                      .map((doctor) => DoctorCard(doctor: doctor))
                      .toList(),
                ),
              ),

              const SizedBox(height: 20),

              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ClientBottomNavigationBar(currentIndex: 0),
    );
  }

  static Widget buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue.shade400),
        ),
      ),
    );
  }

  static Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('عرض الكل', style: TextStyle(color: Colors.blue)),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon),
        ),
        Text(title),
      ],
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Map<String, String> doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,

      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // مهم عشان Column ما يحاولش ياخد كل المساحة
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              'assets/images/bord1.png',
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              doctor['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(doctor['specialty']!),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on_sharp,
                color: Color.fromARGB(255, 49, 47, 47),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(doctor['location']!, style: TextStyle(fontSize: 12)),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.money,
                color: Color.fromARGB(255, 49, 47, 47),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text('الكشف : ${doctor['fee']}', style: TextStyle(fontSize: 12)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 190,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/book_appointment',
                    arguments: doctor,
                  );
                },
                child: const Text('احجز الان'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
