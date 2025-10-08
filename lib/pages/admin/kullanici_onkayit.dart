// kullanici_onkayit.dart

import 'package:flutter/material.dart';

// ==================== Kullanıcı Yönetimi Sayfası (إدارة المستخدمين) ====================

class KullaniciOnkayitPage extends StatelessWidget {
  const KullaniciOnkayitPage({super.key});

  // بيانات وهمية للمستخدمين
  final List<Map<String, dynamic>> _dummyUsers = const [
    {"id": "U001", "name": "Ahmet Yılmaz", "kimlik": "12345678901", "email": "ahmet@mail.com", "phone": "+905051112233", "status": "Aktif", "imgUrl": "assets/img/user1.jpg", "isBanned": false},
    {"id": "U002", "name": "Ayşe Demir", "kimlik": "21098765432", "email": "ayse@mail.com", "phone": "+905559998877", "status": "Aktif", "imgUrl": "assets/img/user2.jpg", "isBanned": false},
    {"id": "U003", "name": "Mehmet Kaya", "kimlik": "33445566778", "email": "mehmet@mail.com", "phone": "+905324445566", "status": "Engelli", "imgUrl": "assets/img/user3.jpg", "isBanned": true},
    {"id": "U004", "name": "Fatma Çelik", "kimlik": "45678912345", "email": "fatma@mail.com", "phone": "+905417778899", "status": "Aktif", "imgUrl": "assets/img/user4.jpg", "isBanned": false},
  ];

  // ==================== بطاقة عرض المستخدم (User Card) ====================
  Widget _buildUserCard(BuildContext context, Map<String, dynamic> user) {
    final bool isBanned = user["isBanned"] as bool;
    final Color statusColor = isBanned ? Colors.red.shade700 : Colors.green.shade700;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: statusColor.withOpacity(0.5), width: 1.5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),

        // الصورة المصغرة (Avatar)
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: isBanned ? Colors.red.shade100 : Colors.blue.shade100,
          // يستخدم أيقونة افتراضية لعدم وجود مسار حقيقي للصورة
          child: Icon(Icons.person, color: isBanned ? Colors.red : Colors.blue.shade700, size: 30),
        ),

        title: Text(
          user["name"] as String,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Kimlik No: ${user["kimlik"]}", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            const SizedBox(height: 4),
            // شارة الحالة (Banned/Active)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isBanned ? "ENGELİ" : "AKTİF",
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),

        // زر المعاينة/الإجراءات
        trailing: const Icon(Icons.chevron_right_rounded, size: 30, color: Colors.indigo),

        onTap: () {
          // فتح نافذة المعاينة التفصيلية
          _showUserDetailsModal(context, user);
        },
      ),
    );
  }

  // ==================== نافذة المعاينة التفصيلية (User Details Modal) ====================
  void _showUserDetailsModal(BuildContext context, Map<String, dynamic> user) {
    bool isBanned = user["isBanned"] as bool; // حالة الحظر يتم تحديثها محليًا

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (stfContext, setState) {
            final Color actionColor = isBanned ? Colors.green : Colors.red;
            final String actionText = isBanned ? "Engeli Kaldır" : "Kullanıcıyı Engelle";

            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${user["name"]} Profili",
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 30),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 2),

                    // 1. الصورة وحالة الحظر
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: isBanned ? Colors.red.shade100 : Colors.blue.shade100,
                            child: Icon(Icons.person_pin, color: isBanned ? Colors.red : Colors.blue.shade700, size: 50),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            isBanned ? "DURUM: ENGELLİ" : "DURUM: AKTİF",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isBanned ? Colors.red : Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 2. معلومات المستخدم الأساسية
                    _buildSectionHeader(title: "Temel Bilgiler", icon: Icons.person_outline, color: Colors.blueGrey),
                    _buildInfoRow("Kimlik No", user["kimlik"] as String, Icons.credit_card_rounded),
                    _buildInfoRow("Email", user["email"] as String, Icons.email_outlined),
                    _buildInfoRow("Telefon", user["phone"] as String, Icons.phone_android),
                    _buildInfoRow("Kayıt Tarihi", "2024-05-15", Icons.calendar_today),
                    const SizedBox(height: 20),

                    // 3. إحصائيات النظام (وهمية)
                    _buildSectionHeader(title: "Sistem İstatistikleri", icon: Icons.bar_chart_rounded, color: Colors.teal),
                    _buildInfoRow("Toplam İhbar", "12", Icons.report_problem),
                    _buildInfoRow("Onaylanan Ceza", "3", Icons.gavel),
                    _buildInfoRow("Güven Skoru", "85%", Icons.verified_user),
                    const SizedBox(height: 40),

                    // 4. أزرار الإدارة (الحظر، التعديل، الحذف)
                    _buildSectionHeader(title: "Yönetici İşlemleri", icon: Icons.settings_applications, color: Colors.deepOrange),

                    // زر الحظر / إلغاء الحظر
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // تحديث حالة الحظر محليًا
                          setState(() {
                            isBanned = !isBanned;
                            user["isBanned"] = isBanned; // تحديث الخريطة (Dummy Data)
                          });

                          // إظهار رسالة
                          _showActionSnackbar(context, isBanned ? "Kullanıcı Engellendi" : "Engel Kaldırıldı", actionColor);
                          // TODO: منطق الإرسال إلى API لتحديث حالة الحظر
                        },
                        icon: Icon(isBanned ? Icons.lock_open : Icons.block, color: Colors.white),
                        label: Text(actionText, style: const TextStyle(fontSize: 16, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: actionColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // صف لأزرار التعديل والحذف
                    Row(
                      children: [
                        // زر التعديل
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _showActionSnackbar(context, "Kullanıcı Düzenleme Formu Açıldı", Colors.blue);
                              // TODO: فتح نافذة أو صفحة لتعديل البيانات الفعلية
                            },
                            icon: const Icon(Icons.edit, color: Colors.indigo),
                            label: const Text("Düzenle", style: TextStyle(color: Colors.indigo)),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: Colors.indigo),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // زر الحذف
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx); // إغلاق المعاينة أولاً
                              _confirmDelete(context, user["id"] as String);
                            },
                            icon: const Icon(Icons.delete_forever, color: Colors.white),
                            label: const Text("Sil", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade600,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ==================== دوال مساعدة للمعاينة ====================

  Widget _buildSectionHeader({required String title, required IconData icon, required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
          ),
          Expanded(child: Divider(color: color.withOpacity(0.5), indent: 15)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          Text(
            "$label:",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _showActionSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Kullanıcıyı Sil"),
        content: Text("Bu işlemi geri alamazsınız. Kullanıcı ID ($userId) hesabını kalıcı olarak silmek istediğinizden emin misiniz?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("İptal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showActionSnackbar(context, "Kullanıcı $userId silindi!", Colors.red);
              // TODO: منطق الحذف الفعلي
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Sil", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ==================== دالة البناء الرئيسية للصفحة ====================

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // شريط البحث والإضافة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // زر إضافة مستخدم جديد
              ElevatedButton.icon(
                onPressed: () {
                  _showActionSnackbar(context, "Yeni Kullanıcı Ekleme Formu Açıldı.", Colors.blue);
                },
                icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                label: const Text("Yeni Kullanıcı", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),

              // حقل البحث
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "İsme veya Kimlik No'ya göre ara...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                    onChanged: (value) {
                      // TODO: تطبيق منطق البحث الفعلي
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // قائمة المستخدمين
          const Text(
            "Sistemdeki Tüm Kullanıcılar (4)",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          const Divider(thickness: 1.5, height: 20),

          ..._dummyUsers.map((user) => _buildUserCard(context, user)).toList(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}