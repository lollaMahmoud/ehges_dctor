import 'package:flutter/material.dart';
import '../../../models/doctor_model.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedGovern = '';
  String selectedPrice = '';
  String selectedRating = '';
  bool filterActive = false;

  final List<String> governorates = [
    'الكل',
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
  ];

  final List<String> priceRanges = [
    'الكل',
    'أقل من 200',
    '200 - 500',
    'أكثر من 500',
  ];

  final List<String> ratings = [
    'الكل',
    '4.5+',
    '4.0+',
    '3.5+',
  ];

  // Mock doctors data
  final List<Doctor> allDoctors = [
    Doctor(
      id: '1',
      name: 'د. أحمد محمد علي',
      specialty: 'Cardiologist',
      specialtyAr: 'استشاري جراحة القلب والصدر',
      rating: 4.9,
      reviewsCount: 5200,
      imageUrl: 'assets/images/doctor1.jpg',
      location: 'القاهرة',
      address: 'الجيزة، مجمع طب القلب المشهور',
      consultationFee: 200,
      description: 'دكتور متخصص في جراحة القلب',
      experienceYears: 15,
      services: [],
      reviews: [],
      isAvailable: true,
    ),
    Doctor(
      id: '2',
      name: 'د. سارة المنصور',
      specialty: 'Pediatrician',
      specialtyAr: 'اخصائية طب الأطفال',
      rating: 4.8,
      reviewsCount: 3100,
      imageUrl: 'assets/images/doctor2.jpg',
      location: 'الرياض',
      address: 'الجيزة، شارع النقرة',
      consultationFee: 150,
      description: 'دكتورة في طب الأطفال',
      experienceYears: 12,
      services: [],
      reviews: [],
      isAvailable: true,
    ),
    Doctor(
      id: '3',
      name: 'د. محمود خليل',
      specialty: 'Dermatologist',
      specialtyAr: 'استشاري الأمراض الجلدية',
      rating: 4.7,
      reviewsCount: 2800,
      imageUrl: 'assets/images/doctor3.jpg',
      location: 'الإسكندرية',
      address: 'الإسكندرية، طريق الحرية',
      consultationFee: 350,
      description: 'دكتور متخصص في الأمراض الجلدية',
      experienceYears: 18,
      services: [],
      reviews: [],
      isAvailable: true,
    ),
    Doctor(
      id: '4',
      name: 'د. ليبل حسن',
      specialty: 'Dentist',
      specialtyAr: 'طبيب أسنان',
      rating: 4.6,
      reviewsCount: 1950,
      imageUrl: 'assets/images/doctor4.jpg',
      location: 'القاهرة',
      address: 'القاهرة، مدينة نصر',
      consultationFee: 250,
      description: 'طبيب أسنان متخصص',
      experienceYears: 10,
      services: [],
      reviews: [],
      isAvailable: true,
    ),
  ];

  late List<Doctor> filteredDoctors;

  @override
  void initState() {
    super.initState();
    filteredDoctors = allDoctors;
  }

  void _applyFilters() {
    setState(() {
      filteredDoctors = allDoctors.where((doctor) {
        bool matchesSearch =
            _searchController.text.isEmpty ||
            doctor.name.contains(_searchController.text) ||
            doctor.specialtyAr.contains(_searchController.text);

        bool matchesGovern = selectedGovern.isEmpty ||
            selectedGovern == 'الكل' ||
            doctor.location == selectedGovern;

        bool matchesPrice = selectedPrice.isEmpty ||
            selectedPrice == 'الكل' ||
            _checkPriceRange(doctor.consultationFee);

        bool matchesRating = selectedRating.isEmpty ||
            selectedRating == 'الكل' ||
            _checkRating(doctor.rating);

        return matchesSearch && matchesGovern && matchesPrice && matchesRating;
      }).toList();

      filterActive = selectedGovern.isNotEmpty ||
          selectedPrice.isNotEmpty ||
          selectedRating.isNotEmpty;
    });
  }

  bool _checkPriceRange(int price) {
    switch (selectedPrice) {
      case 'أقل من 200':
        return price < 200;
      case '200 - 500':
        return price >= 200 && price <= 500;
      case 'أكثر من 500':
        return price > 500;
      default:
        return true;
    }
  }

  bool _checkRating(double rating) {
    switch (selectedRating) {
      case '4.5+':
        return rating >= 4.5;
      case '4.0+':
        return rating >= 4.0;
      case '3.5+':
        return rating >= 3.5;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'قائمة الأطباء',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search and filter section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _searchController,
                    textAlign: TextAlign.right,
                    onChanged: (_) => _applyFilters(),
                    decoration: InputDecoration(
                      hintText: 'ابحث عن طبيب...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    children: [
                      _buildFilterDropdown(
                        label: 'المحافظة',
                        items: governorates,
                        selectedValue: selectedGovern,
                        onChanged: (value) {
                          setState(() {
                            selectedGovern = value ?? '';
                          });
                          _applyFilters();
                        },
                      ),
                      const SizedBox(width: 12),
                      _buildFilterDropdown(
                        label: 'السعر',
                        items: priceRanges,
                        selectedValue: selectedPrice,
                        onChanged: (value) {
                          setState(() {
                            selectedPrice = value ?? '';
                          });
                          _applyFilters();
                        },
                      ),
                      const SizedBox(width: 12),
                      _buildFilterDropdown(
                        label: 'التقييم',
                        items: ratings,
                        selectedValue: selectedRating,
                        onChanged: (value) {
                          setState(() {
                            selectedRating = value ?? '';
                          });
                          _applyFilters();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Doctors list
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد نتائج',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'حاول تغيير معايير البحث',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      return _buildDoctorCard(
                        filteredDoctors[index],
                        context,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required List<String> items,
    required String selectedValue,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        hint: Text(label),
        value: selectedValue.isEmpty ? null : selectedValue,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A8B6F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        doctor.name,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctor.specialtyAr,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'ج.ح ${doctor.consultationFee}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${doctor.rating}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                '/doctor_details',
                arguments: doctor,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF0066CC),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'احجز الآن',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
