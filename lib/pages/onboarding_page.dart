import 'package:flutter/material.dart';

// ************ المسار التقديري لـ LoginPage ************
import 'auth/login_page.dart'; // تأكد من أن المسار صحيح

// ==================== Onboarding Page ====================
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Map<String, String>> _onboardingData = [
    {"image": "assets/intro1.png"},
    {"image": "assets/intro2.png"},
    {"image": "assets/intro3.png"},
    {"image": "assets/intro4.png"},
    {"image": "assets/intro5.png"},
  ];

  void _next() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _skip(); // إذا كان الأخير، ننتقل للتسجيل/البدء
    }
  }

  // دالة _prev() تم إزالتها بالكامل

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // تحديد نص الزر بناءً على الشاشة الحالية
    final String buttonText =
    _currentIndex == _onboardingData.length - 1 ? "Başla" : "Devam Et";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. منطقة عرض الصور (PageView)
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset(
                    _onboardingData[index]['image']!,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.75,
                    errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.broken_image,
                        size: MediaQuery.of(context).size.height * 0.4,
                        color: Colors.red
                    ),
                  ),
                ),
              );
            },
          ),

          // 2. زر تخطي (Geç) في الأعلى
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _skip,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                backgroundColor: Colors.blue.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Geç",
                style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 3. الأزرار والمؤشرات في الأسفل (فوق الصورة)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // المؤشرات (النقاط)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                          (index) => Container(
                        margin: const EdgeInsets.all(4),
                        width: _currentIndex == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: _currentIndex == index ? Colors.blue : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // زر التنقل/البدء الوحيد
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton.icon(
                      onPressed: _next,
                      icon: Icon(
                        _currentIndex == _onboardingData.length - 1
                            ? Icons.check
                            : Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: Text(
                        buttonText, // استخدام النص المحدد
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // توسيع الزر
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}