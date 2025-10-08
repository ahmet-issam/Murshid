import 'package:flutter/material.dart';

// تعريف استثناء مخصص للتحقق من بيانات الاعتماد
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

class AuthProvider extends ChangeNotifier {
  // حالة تسجيل الدخول الافتراضية
  bool _isLoggedIn = false;
  String? _userType; // 'user' أو 'admin'

  bool get isLoggedIn => _isLoggedIn;
  String? get userType => _userType;
  bool get isAdmin => _isLoggedIn && _userType == 'admin';

  // ==========================================================
  // حسابات الاختبار الثابتة (للمحاكاة فقط)
  // ==========================================================
  final Map<String, dynamic> _mockUsers = const {
    // حساب المشرف (يجب استخدام هذا الحساب فقط من خلال التحقق الصارم في LoginPage)
    'admin@admin.com': {'password': 'admin123', 'type': 'admin'},
    // حساب المستخدم العادي (للتجربة عبر الـ Provider)
    'user@test.com': {'password': 'user12345', 'type': 'user'},
  };

  // ==========================================================
  // دالة محاكاة لتسجيل الدخول (مع تحقق صارم من كلمة المرور)
  // ==========================================================
  Future<void> login(String email, String password) async {
    // 1. محاكاة تأخير الشبكة
    await Future.delayed(const Duration(seconds: 1));

    // 2. التحقق من وجود المستخدم في قاعدة البيانات الوهمية
    final userData = _mockUsers[email];

    if (userData == null) {
      // إذا لم يتم العثور على المستخدم
      throw const AuthException("Böyle bir kullanıcı bulunamadı.");
    }

    // 3. التحقق من كلمة المرور
    if (userData['password'] != password) {
      // إذا كانت كلمة المرور غير صحيحة
      throw const AuthException("Şifre yanlış. Lütfen tekrar deneyin.");
    }

    // 4. نجاح تسجيل الدخول
    _userType = userData['type'] as String;
    _isLoggedIn = true;

    // إخطار جميع العناصر المستمعة (Listeners) بتحديث الحالة
    notifyListeners();
  }

  // ==========================================================
  // دالة تسجيل الخروج
  // ==========================================================
  void logout() {
    _isLoggedIn = false;
    _userType = null;
    notifyListeners();
  }
}
