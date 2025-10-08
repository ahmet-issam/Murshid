// genel_duyurular_page.dart

import 'package:flutter/material.dart';

// ==================== Genel Duyurular Sayfası (إدارة الإشعارات العامة) ====================

class GenelDuyurularPage extends StatefulWidget {
  const GenelDuyurularPage({super.key});

  @override
  State<GenelDuyurularPage> createState() => _GenelDuyurularPageState();
}

class _GenelDuyurularPageState extends State<GenelDuyurularPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedTarget = 'Tüm Kullanıcılar'; // الخيار الافتراضي للاستهداف

  // قائمة الإشعارات الوهمية المرسلة
  final List<Map<String, dynamic>> _sentAnnouncements = [
    {"title": "Sistem Bakımı", "date": "2025-09-28", "target": "Tüm Kullanıcılar", "status": "Gönderildi"},
    {"title": "Yeni Ceza Oranları", "date": "2025-10-01", "target": "Aktif Kullanıcılar", "status": "Gönderildi"},
    {"title": "Mobil Uygulama Güncellemesi", "date": "2025-10-03", "target": "Ceza Alanlar", "status": "Gönderildi"},
  ];

  // خيارات الاستهداف
  final List<String> _targetOptions = [
    'Tüm Kullanıcılar', // جميع المستخدمين
    'Aktif Kullanıcılar', // المستخدمون النشطون
    'Engellenmiş Kullanıcılar', // المستخدمون المحظورون
    'Ceza Alanlar', // من لديهم غرامات معتمدة
    'İhbar Bildirenler', // من أرسلوا بلاغات
  ];

  // ==================== دالة إرسال الإشعار (Send Announcement) ====================
  void _sendAnnouncement() {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen Başlık ve İçerik alanlarını doldurun."), backgroundColor: Colors.red),
      );
      return;
    }

    // محاكاة عملية الإرسال
    setState(() {
      _sentAnnouncements.insert(0, {
        "title": title,
        "date": DateTime.now().toString().substring(0, 10),
        "target": _selectedTarget,
        "status": "Gönderildi",
      });
    });

    _titleController.clear();
    _contentController.clear();

    // رسالة نجاح
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Duyuru başarıyla gönderildi! Hedef: $_selectedTarget"), backgroundColor: Colors.green),
    );
  }

  // ==================== بناء واجهة الإرسال (Gönderim Paneli) ====================
  Widget _buildSendPanel(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(bottom: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Yeni Duyuru / Bildirim Gönder",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const Divider(height: 25, thickness: 1.5),

            // حقل عنوان الإشعار
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Duyuru Başlığı",
                hintText: "Örn: Sistem Bakımı",
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // حقل محتوى الإشعار
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Duyuru İçeriği",
                hintText: "Kullanıcılara göndermek istediğiniz mesaj...",
                prefixIcon: Icon(Icons.message_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // آلية الاستهداف (Dropdown)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Hedef Kitle Seçimi",
                prefixIcon: Icon(Icons.people_alt, color: Colors.orange),
                border: OutlineInputBorder(),
              ),
              value: _selectedTarget,
              items: _targetOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTarget = newValue!;
                });
              },
            ),
            const SizedBox(height: 30),

            // زر الإرسال
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sendAnnouncement,
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                label: const Text("Şimdi Gönder", style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== بناء سجل الإشعارات (Gönderilmiş Duyurular) ====================
  Widget _buildSentAnnouncementsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gönderilmiş Duyuru Kayıtları",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const Divider(height: 20, thickness: 1.5),

        // قائمة البطاقات للإشعارات المرسلة
        ..._sentAnnouncements.map((announcement) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.campaign, color: Colors.purple, size: 30),
              title: Text(
                announcement["title"] as String,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text("Hedef: ${announcement["target"]}"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(announcement["date"] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Icon(Icons.check_circle, size: 18, color: Colors.green.shade600),
                ],
              ),
              onTap: () {
                // محاكاة فتح التفاصيل
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Duyuru detayları açıldı: ${announcement["title"]}")),
                );
              },
            ),
          );
        }).toList(),
      ],
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
          const Text(
            "Duyuru ve Bildirim Yönetimi",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A)),
          ),
          const SizedBox(height: 20),

          // 1. لوحة إرسال الإشعار
          _buildSendPanel(context),

          // 2. سجل الإشعارات المرسلة
          _buildSentAnnouncementsList(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}