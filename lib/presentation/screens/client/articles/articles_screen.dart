import 'package:flutter/material.dart';
import '../widgets/client_bottom_navigation_bar.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';

  final List<Map<String, String>> articles = [
    {
      'title': 'فوائد الصيام المتقطع',
      'excerpt': 'تعرف إزاي الصيام المتقطع بيحسن الأيض والنشاط والتركيز.',
      'category': 'التغذية',
      'date': '15 مايو 2024',
      'image': 'assets/images/bord1.png',
      'fullText':
          'الصيام المتقطع ليه فوائد زي تحسين حساسية الإنسولين، خسارة الوزن، وصفاء التفكير.',
    },
    {
      'title': 'أهمية تطعيم الأطفال',
      'excerpt': 'التطعيم مهم عشان يحمي الأطفال والمجتمع من الأمراض.',
      'category': 'الطب الوقائي',
      'date': '12 مايو 2024',
      'image': 'assets/images/bord1.png',
      'fullText':
          'التطعيمات المنتظمة بتحافظ على صحة الأولاد وتقليل انتقال الأمراض في المجتمع.',
    },
    {
      'title': 'اليوغا لتخفيف التوتر',
      'excerpt': 'اليوغا بتساعد الجسم والعقل على الاسترخاء وتقليل الضغوط.',
      'category': 'الصحة النفسية',
      'date': '10 مايو 2024',
      'image': 'assets/images/bord1.png',
      'fullText':
          'ممارسة اليوغا بانتظام بتخفض القلق، بتحسن المرونة، وبتسهم في الرفاهية العامة.',
    },
  ];

  List<Map<String, String>> get filteredArticles {
    final query = _searchController.text.toLowerCase();
    return articles.where((article) {
      final matchesText =
          query.isEmpty ||
          article['title']!.toLowerCase().contains(query) ||
          article['excerpt']!.toLowerCase().contains(query);
      final matchesCategory =
          selectedCategory == 'All' || article['category'] == selectedCategory;
      return matchesText && matchesCategory;
    }).toList();
  }

  final List<String> categories = [
    'الكل',
    'التغذية',
    'الطب الوقائي',
    'الصحة النفسية',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: const Text(
          'المقالات الطبية',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث عن مقالة...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            SizedBox(
              height: 45,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return ChoiceChip(
                    selected: isSelected,
                    label: Text(category),
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/article_details',
                        arguments: article,
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (article['image'] != null)
                            Image.asset(
                              article['image']!,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      article['category']!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article['title']!,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  article['excerpt']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      article['date']!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(
                                          255,
                                          164,
                                          158,
                                          158,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        '/article_details',
                                        arguments: article,
                                      ),
                                      child: const Text('اقرأ المزيد'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ClientBottomNavigationBar(currentIndex: 2),
    );
  }
}
