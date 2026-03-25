import 'package:flutter/material.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'احجز دكتورك',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const Icon(Icons.notifications_none, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu, color: Colors.blue),
          )
        ],
      ),
      body:SafeArea(child: 
       SingleChildScrollView(
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
                  buildTextField('ابحث عن طبيب أو عيادة...'),
                  const SizedBox(height: 10),
                  buildTextField('التخصص'),
                  const SizedBox(height: 10),
                  buildTextField('المحافظة'),
                  const SizedBox(height: 10),
                  buildTextField('المدينة'),
                  const SizedBox(height: 15),
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
                          Icon(Icons.search)
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
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  DoctorCard(),
                  DoctorCard(),
                  DoctorCard(),
                  DoctorCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      )
      
    );
  }

  static Widget buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(53),
          borderSide: BorderSide.none,
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
        Text(title)
      ],
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

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
        mainAxisSize: MainAxisSize.min, // مهم عشان Column ما يحاولش ياخد كل المساحة
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('د. محمد علي', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('استشاري عظام'),
          ),
          Row(
            children: const [
              Icon(Icons.location_on_sharp, color: Color.fromARGB(255, 49, 47, 47), size: 16),
              SizedBox(width: 4),
              Text('القاهرة', style: TextStyle(fontSize: 12)),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.money, color: Color.fromARGB(255, 49, 47, 47), size: 16),
              SizedBox(width: 4),
              Text('الكشف : 300', style: TextStyle(fontSize: 12)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('احجز الآن'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 