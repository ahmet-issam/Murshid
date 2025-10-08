import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

// ==================== صفحة تسجيل الدخول (LoginPage) ====================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginIdentifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final enteredId = _loginIdentifierController.text.trim();
    final enteredPassword = _passwordController.text;

    // =======================================================
    // 1. التحقق من بيانات المشرف المحددة (admin@admin.com / admin123)
    // =======================================================
    const adminId = "admin@admin.com";
    const adminPassword = "admin123";

    if (enteredId == adminId) {
      if (enteredPassword == adminPassword) {
        // نجاح تسجيل دخول المشرف (محدد)
        Navigator.pushReplacementNamed(context, '/admin');
      } else {
        // فشل في كلمة المرور للمشرف المحدد
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Yönetici girişi başarısız. Kimlik veya Şifre yanlış.")),
        );
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // =======================================================
    // 1.5. التحقق من بيانات المستخدم الثابت (99151413104 / 25092004)
    // =******************** الإضافة الجديدة ********************
    // =======================================================
    const staticUserId = "99151413104";
    const staticUserPassword = "25092004";

    if (enteredId == staticUserId) {
      if (enteredPassword == staticUserPassword) {
        // نجاح تسجيل دخول المستخدم الثابت
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // فشل في كلمة المرور للمستخدم الثابت
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Kullanıcı girişi başarısız. Kimlik veya Şifre yanlış.")),
        );
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }
    // ********************* نهاية الإضافة ********************

    // =======================================================
    // 2. تسجيل دخول المستخدم العادي (عبر الـ Provider)
    // =======================================================
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      await authProvider.login(enteredId, enteredPassword);

      String route = authProvider.isAdmin ? '/admin' : '/home';

      Navigator.pushReplacementNamed(context, route);

    } catch (e) {
      // إذا فشل الـ Provider في تسجيل الدخول وطرح استثناء
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Giriş başarısız. Lütfen bilgileri kontrol edin.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _loginIdentifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // اللوجو
                Image.asset(
                  'assets/dra.png',
                  height: 100,
                ),

                const SizedBox(height: 10),
                Text("Giriş Yap", textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue.shade700)),
                const SizedBox(height: 40),

                // حقل الإدخال الموحد للكيمليك والبريد الإلكتروني
                TextFormField(
                  controller: _loginIdentifierController,
                  keyboardType: TextInputType.text,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen Kimlik No. veya E-posta girin.';
                    }

                    // التحقق من رقم الكيمليك (11 خانة ورقمي)
                    final isKimlik = value.length == 11 && int.tryParse(value) != null;

                    // التحقق من البريد الإلكتروني (يحتوي على @)
                    final isEmail = value.contains('@');

                    if (isKimlik || isEmail) {
                      return null;
                    }

                    return 'Geçersiz format. 11 haneli Kimlik No. veya E-posta.';
                  },

                  decoration: InputDecoration(
                      labelText: 'Kimlik No. / E-posta',
                      prefixIcon: const Icon(Icons.person),
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                  ),
                ),

                const SizedBox(height: 20),

                // حقل كلمة المرور
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  validator: (value) => value == null || value.length < 6 ? 'Şifre 6 karakterden az olmamalı.' : null,
                  decoration: InputDecoration(
                    labelText: 'Şifre', prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () { setState(() { _isPasswordVisible = !_isPasswordVisible; }); },
                    ),
                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 30),

                // زر تسجيل الدخول
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isLoading
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                      : const Text('Giriş', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 20),

                // زر إنشاء حساب
                TextButton(
                  onPressed: _isLoading ? null : () { Navigator.pushNamed(context, '/register'); },
                  child: const Text('Hesabın yok mu? Yeni Hesap Oluştur', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}