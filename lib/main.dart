// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// استيراد مزود المصادقة الذي أنشأناه
import 'providers/auth_provider.dart';

// ==================== استيراد الصفحات المطلوبة ====================
import 'pages/onboarding_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/user/register_page.dart';
// 💡 تعديل اسم الملف ليطابق ما ذكرته سابقاً
import 'pages/admin/admin_menu.dart';
import 'pages/user/home_page.dart';
import 'pages/user/new_ihbar_page.dart';
import 'pages/user/my_reports_page.dart';

void main() {
  // ************ التعديل الرئيسي: تغليف التطبيق بـ Provider ************
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MursidApp(),
    ),
  );
  // *******************************************************************
}

class MursidApp extends StatelessWidget {
  const MursidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.blue.shade700,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),

      initialRoute: '/onboarding',

      routes: {
        // 🚀 تم التعديل هنا: المسار الأساسي '/' يجب أن يكون صفحة تسجيل الدخول.
        // هذا هو الهدف الذي سيوجه إليه زر الخروج في القائمة الجانبية.
        '/': (context) => LoginPage(),

        // مسار العرض التمهيدي يظل منفصلاً
        '/onboarding': (context) => const OnboardingPage(),

        // مسار تسجيل الدخول - يمكن الإبقاء عليه لتوجيهات صريحة
        '/login': (context) => LoginPage(),

        '/register': (context) => const RegisterPage(),

        '/home': (context) => const HomePage(),
        '/new_report': (context) => const NewIhbarPage(),
        '/my_reports': (context) => const MyReportsPage(),

        // مسار لوحة تحكم المشرف
        '/admin': (context) => const AdminPage(),
      },
    );
  }
}