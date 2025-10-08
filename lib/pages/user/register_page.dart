import 'package:flutter/material.dart';
// تم تصحيح مسار الاستيراد لصفحة تسجيل الدخول (الخروج ثم الدخول لمجلد auth)
import '../auth/login_page.dart';

// ==================== Register Page ====================
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 1. تعريف متحكمات حقول الإدخال المطلوبة
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _kimlikController = TextEditingController(); // رقم الكيمليك
  final TextEditingController _addressController = TextEditingController(); // العنوان
  final TextEditingController _passwordController = TextEditingController();

  // متغيرات الحالة
  DateTime? _dateOfBirth; // تاريخ الميلاد
  bool _obscurePassword = true;

  // دالة لاختيار تاريخ الميلاد
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000), // تاريخ افتراضي
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Doğum Tarihi Seçiniz',
      cancelText: 'İptal',
      confirmText: 'Onayla',
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  // دالة التسجيل (سيستخدمها الأدمن لإنشاء حساب جديد)
  void _register() {
    // جمع البيانات
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String kimlik = _kimlikController.text.trim();
    String address = _addressController.text.trim();
    String password = _passwordController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || kimlik.isEmpty || address.isEmpty || password.isEmpty || _dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurunuz.")),
      );
      return;
    }

    // هنا يجب أن يتم إرسال البيانات إلى قاعدة البيانات

    // بعد التسجيل بنجاح، نعود إلى صفحة تسجيل الدخول
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Kullanıcı başarıyla oluşturuldu. Kimlik No ile giriş yapabilirsiniz.")),
    );

    Navigator.pop(context); // العودة إلى صفحة تسجيل الدخول
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Kullanıcı Kaydı"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Yeni Kullanıcı Oluştur",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 25),

                // 1. الاسم الأول
                TextField(
                  controller: _firstNameController,
                  decoration: _inputDecoration(Icons.person, "Ad (İsim)"),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 15),

                // 2. اسم العائلة
                TextField(
                  controller: _lastNameController,
                  decoration: _inputDecoration(Icons.person_outline, "Soyad (Ailesi)"),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 15),

                // 3. رقم الكيمليك (معرف تسجيل الدخول)
                TextField(
                  controller: _kimlikController,
                  decoration: _inputDecoration(Icons.credit_card, "Kimlik Numarası"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),

                // 4. تاريخ الميلاد
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: _inputDecoration(Icons.calendar_today, "Doğum Tarihi"),
                    child: Text(
                      _dateOfBirth == null
                          ? 'Bir tarih seçin'
                          : '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}',
                      style: TextStyle(
                        fontSize: 16,
                        color: _dateOfBirth == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // 5. العنوان
                TextField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: _inputDecoration(Icons.location_on, "Adres (Adresiniz)"),
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 15),

                // 6. كلمة السر
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: _inputDecoration(Icons.lock, "Şifre").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // زر الإنشاء (التسجيل)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _register,
                    icon: const Icon(Icons.person_add, color: Colors.white),
                    label: const Text(
                      "Kullanıcı Oluştur",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // لون مختلف للتمييز
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }

  // دالة مساعدة لتنسيق حقول الإدخال
  InputDecoration _inputDecoration(IconData icon, String labelText) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      labelText: labelText,
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }
}