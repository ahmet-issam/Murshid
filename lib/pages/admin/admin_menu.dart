// admin_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// نحتاج إلى إعادة تعريف الأقسام الجديدة هذه:
import 'admin_dashboard_page.dart';
import 'ihbar_yonetimi_page.dart';
import 'raporlar_page.dart';
import 'kullanici_onkayit.dart';
import 'genel_duyurular_page.dart';

// ==================== صفحة المدير (AdminPage) - تصميم مميز ====================

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  // قائمة الصفحات/الأقسام - الترتيب الجديد
  final List<Widget> _adminPages = const [
    AdminDashboardPage(),     // 1. Ana Sayfa (الصفحة الرئيسيه)
    IhbarYonetimiPage(),      // 2. İhbar Yönetimi (ادارة البلاغات)
    RaporlarPage(),           // 3. Sistem Yönetimi (ادارة نظام البلاغات)
    KullaniciOnkayitPage(),   // 4. Kullanıcı Yönetimi (ادارة المستخدمين)
    GenelDuyurularPage(),     // 5. Genel Duyurular (الاشعارات العام)
  ];

  // قائمة عناصر التنقل - الأسماء والأيقونات الجديدة بالترتيب
  final List<Map<String, dynamic>> _navItems = const [
    {'title': "Ana Sayfa", 'icon': Icons.home_rounded}, // الصفحة الرئيسية
    {'title': "İhbar Yönetimi", 'icon': Icons.report_problem_rounded}, // ادارة البلاغات
    {'title': "Sistem Yönetimi", 'icon': Icons.settings_applications_rounded}, // ادارة نظام البلاغات
    {'title': "Kullanıcı Yönetimi", 'icon': Icons.people_alt_rounded}, // ادارة المستخدمين
    {'title': "Genel Duyurular", 'icon': Icons.campaign_rounded}, // الاشعارات العام
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // إغلاق القائمة الجانبية بعد التحديد
    Navigator.pop(context);
  }

  void _logout() {
    // منطق تسجيل الخروج الفعلي (مثل إزالة التوكن والتوجيه إلى صفحة تسجيل الدخول)
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  // ==================== القائمة الجانبية (الدرج) ====================
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.blue.shade900, // خلفية داكنة فاخرة
      child: Column(
        children: <Widget>[
          // رأس القائمة الجانبية (Header)
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.admin_panel_settings, size: 30, color: Color(0xFF1565C0)),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Mürşid Yönetimi',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'admin@admin.com',
                      style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // عناصر القائمة
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: _selectedIndex == index ? Colors.blue.shade600.withOpacity(0.7) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(_navItems[index]['icon'], color: Colors.white, size: 26),
                    title: Text(_navItems[index]['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    onTap: () => _onItemTapped(index),
                    selected: _selectedIndex == index,
                    hoverColor: Colors.blue.shade700,
                  ),
                );
              },
            ),
          ),

          // زر تسجيل الخروج في الأسفل
          const Divider(color: Colors.white54, height: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top: 10),
            child: ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.redAccent, size: 26),
              title: const Text('Çıkış Yap', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onTap: _logout,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. الشريط العلوي (AppBar) - تم إضافة زر الجرس
      appBar: AppBar(
        title: Text(
          _navItems[_selectedIndex]['title'] as String,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,

        // --- إضافة زر الإشعارات (الجرس) ---
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 28),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("إشعارات النظام تظهر هنا.")),
              );
              // TODO: افتح صفحة أو قائمة إشعارات منبثقة (Notification Drawer/Page)
            },
          ),
          const SizedBox(width: 5),
        ],
        // ------------------------------------
      ),

      // 2. القائمة الجانبية (Drawer)
      drawer: _buildDrawer(),

      // 3. محتوى الصفحة
      body: _adminPages[_selectedIndex],

      // 4. شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems.map((item) => BottomNavigationBarItem(
          icon: Icon(item['icon']),
          label: item['title'].toString().split(' ').first,
        )).toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey.shade600,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}