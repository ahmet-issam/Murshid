// admin_dashboard_page.dart

import 'package:flutter/material.dart';

// 💡 لا نحتاج لاستيراد صفحة تسجيل الدخول هنا بعد الآن
// import 'package:your_app_name/pages/auth/login_page.dart';

// ==================== Ana Sayfa / Yönetici Paneli (الصفحة الرئيسية) ====================
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  // ❌ تم حذف دالة _logout() بالكامل

  // =================================================================
  // مكون مساعد: بطاقة مؤشرات الأداء الرئيسية (KPI Card)
  // =================================================================
  Widget _buildKpiCard({
    required String title,
    required String value,
    required IconData icon,
    required MaterialColor color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 30),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color.shade900),
            ),
          ],
        ),
      ),
    );
  }

  // =================================================================
  // مكون مساعد: زر الإجراء السريع (Quick Action Button)
  // =================================================================
  Widget _buildQuickActionButton(BuildContext context, String title, IconData icon, MaterialColor color) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$title tıklandı. Özel işlem başlatılacak.")),
            );
            // TODO: إضافة منطق التنقل أو الإجراء هنا
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: color.shade400, width: 2),
            ),
            child: Icon(icon, color: color.shade700, size: 30),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
        ),
      ],
    );
  }

  // =================================================================
  // مكون مساعد: بطاقة الإحصائيات الزمنية (Timeline Stats Card)
  // =================================================================
  Widget _buildTimeStatCard(String title, String value, IconData icon, MaterialColor color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color.shade800)),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // بيانات لوحة تحكم عامة (KPI)
    final List<Map<String, dynamic>> kpiData = [
      {"title": "Toplam İhbarlar", "value": "1.250", "icon": Icons.report_problem, "color": Colors.blue},
      {"title": "Aktif Kullanıcı", "value": "254", "icon": Icons.people_alt, "color": Colors.green},
      {"title": "Toplam Para Cezası (₺)", "value": "450K", "icon": Icons.attach_money, "color": Colors.red},
    ];

    // بيانات وهمية للإحصائيات الزمنية
    final List<Map<String, dynamic>> timeStats = [
      {"title": "Bugünkü İhbarlar", "value": "7", "icon": Icons.calendar_today, "color": Colors.red},
      {"title": "Haftalık İhbarlar", "value": "45", "icon": Icons.calendar_view_week, "color": Colors.orange},
      {"title": "Aylık İhbarlar", "value": "190", "icon": Icons.calendar_view_month, "color": Colors.blue},
      {"title": "Yıllık İhbarlar", "value": "1.2K", "icon": Icons.calendar_today_outlined, "color": Colors.purple},
    ];

    // تم الإبقاء على Scaffold و AppBar الأساسيين
    return Scaffold(
      appBar: AppBar(
        // يمكنك إزالة هذا السطر إذا كنت تستخدم Drawer (قائمة جانبية)
        automaticallyImplyLeading: false,
        title: const Text(
          "Yönetici Paneli",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        // ❌ تم إزالة: actions: [IconButton(icon: Icon(Icons.logout...)]
        actions: const [
          // يمكن إضافة أزرار أخرى هنا لاحقاً إذا لزم الأمر
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. لوحة تحكم عامة (نظرة عامة على KPI)
            const Text(
              "Genel Durum Paneli",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
            ),
            const SizedBox(height: 15),

            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sistem Performans Özeti",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const Divider(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: kpiData.map((data) => _buildKpiCard(
                        title: data["title"] as String,
                        value: data["value"] as String,
                        icon: data["icon"] as IconData,
                        color: data["color"] as MaterialColor,
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),


            // 2. أزرار الإجراء السريع (4 أزرار مدورة)
            const Text(
              "Hızlı Erişim Butonları",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.deepPurple),
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickActionButton(context, "Zar 1", Icons.add_business, Colors.deepPurple),
                _buildQuickActionButton(context, "Zar 2", Icons.bar_chart, Colors.teal),
                _buildQuickActionButton(context, "Zar 3", Icons.person_add, Colors.blue),
                _buildQuickActionButton(context, "Zar 4", Icons.settings_applications, Colors.orange),
              ],
            ),
            const SizedBox(height: 40),

            // 3. الإحصائيات الزمنية (Günlük, Haftalık, Aylık, Yıllık)
            const Text(
              "Zaman Çizelgesi İhbar İstatistikleri",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
            ),
            const Divider(height: 20, thickness: 1.5),

            // عرض الإحصائيات في قائمة بسيطة
            ...timeStats.map((stat) => _buildTimeStatCard(
              stat["title"] as String,
              stat["value"] as String,
              stat["icon"] as IconData,
              stat["color"] as MaterialColor,
            )).toList(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}