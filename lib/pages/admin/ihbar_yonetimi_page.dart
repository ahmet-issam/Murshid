// ihbar_yonetimi_page.dart

import 'package:flutter/material.dart';

// ==================== İhbar Yönetimi Sayfası (مركز العمل الاحترافي) ====================
// (Şikayet ve Karar Yönetimi)
class IhbarYonetimiPage extends StatelessWidget {
  const IhbarYonetimiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Yeni, İşlemde, Tamamlanan
      child: Column(
        children: [
          // شريط الأزرار والتصدير
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // زر التصدير إلى جداول بيانات Google
                ElevatedButton.icon(
                  onPressed: () {
                    // محاكاة عملية التصدير
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Tüm İhbar Verileri Excel/Sheets'e aktarılıyor..."),
                        backgroundColor: Colors.teal,
                      ),
                    );
                  },
                  icon: const Icon(Icons.cloud_download_rounded, color: Colors.white),
                  label: const Text("Rapor İndir", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                ),

                // زر البحث والفلترة المتقدمة
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gelişmiş Filtre ve Arama açıldı.")),
                    );
                  },
                  icon: const Icon(Icons.filter_list_alt, size: 30, color: Color(0xFF1E3A8A)),
                  tooltip: "Filtrele ve Ara",
                ),
              ],
            ),
          ),

          // Sekme Başlıkları (TabBar)
          const TabBar(
            indicatorColor: Color(0xFF1E3A8A), // أزرق داكن للمؤشر
            labelColor: Color(0xFF1E3A8A),
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            tabs: [
              Tab(text: "🔴 Yeni İhbarlar"), // جديد
              Tab(text: "🟠 İşlemde"), // قيد المعالجة
              Tab(text: "🟢 Tamamlanan"), // منجز
            ],
          ),

          // Sekme İçerikleri (TabBarView)
          const Expanded(
            child: TabBarView(
              children: [
                // 1. Yeni İhbarlar
                _IhbarList(status: "Yeni"),
                // 2. İşlemdeki İhbarlar
                _IhbarList(status: "İşlemde"),
                // 3. Tamamlanan İhbarlar
                _IhbarList(status: "Tamamlanan"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== İhbar Listesini Gösteren Yardımcı Widget ====================
class _IhbarList extends StatelessWidget {
  final String status;

  const _IhbarList({required this.status});

  // تحديد الستايل بناءً على حالة البلاغ
  Map<String, dynamic> _getStatusStyle(String status) {
    switch (status) {
      case "Yeni":
        return {"color": Colors.red.shade700, "text": "YENİ", "icon": Icons.new_releases_rounded};
      case "İşlemde":
        return {"color": Colors.orange.shade700, "text": "İŞLEMDE", "icon": Icons.hourglass_empty_rounded};
      case "Tamamlanan":
        return {"color": Colors.green.shade700, "text": "TAMAMLANDI", "icon": Icons.check_circle_rounded};
      default:
        return {"color": Colors.grey, "text": "BİLİNMİYOR", "icon": Icons.help_outline};
    }
  }

  // بناء بطاقة البلاغ الاحترافية
  Widget _buildIhbarCard(BuildContext context, Map<String, dynamic> item) {
    final style = _getStatusStyle(item["status"] as String);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: style["color"].withOpacity(0.5), width: 1.5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),

        // الأيقونة والحالة
        leading: Icon(style["icon"] as IconData, color: style["color"], size: 35),

        title: Text(
          "${item["title"]} (ID: ${item["id"]})",
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text("Bildiren: ${item["reporter"]} | Tarih: ${item["date"]}", style: TextStyle(color: Colors.grey.shade600)),

            // شارة الحالة في أسفل البطاقة
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: style["color"].withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  style["text"] as String,
                  style: TextStyle(
                      color: style["color"],
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
              ),
            ),
          ],
        ),

        // زر المعاينة
        trailing: Icon(Icons.chevron_right_rounded, size: 28, color: Colors.blue.shade700),

        onTap: () {
          // فتح نافذة المعاينة الاحترافية
          _showIhbarDetailsModal(context, item);
        },
      ),
    );
  }

  // قائمة وهمية للبلاغات
  @override
  Widget build(BuildContext context) {
    // بيانات وهمية مع معلومات إضافية للمعاينة
    final List<Map<String, dynamic>> dummyData = [
      {"id": "001", "title": "Çöp Yığılması", "reporter": "Ali Yılmaz", "date": "2025-10-01", "status": "Yeni", "location": "Konya, Merkez", "violation_type": "Çevre İhlali", "media_type": "Image", "details": "Büyük bir çöp yığını var, acil müdahale gerekli."},
      {"id": "002", "title": "Bozuk Aydınlatma", "reporter": "Fatma Demir", "date": "2025-09-28", "status": "İşlemde", "location": "Ankara, Çankaya", "violation_type": "Altyapı Arızası", "media_type": "Video", "details": "Sokak lambaları 3 gündür yanmıyor. Güvenlik riski var."},
      {"id": "003", "title": "Yol Hasarı", "reporter": "Mehmet Kaya", "date": "2025-09-20", "status": "Tamamlanan", "location": "İstanbul, Beyoğlu", "violation_type": "Trafik İhlali", "media_type": "Image", "details": "Yolda derin bir çukur oluşmuştu, tamir edildi."},
      {"id": "004", "title": "Gürültü Kirliliği", "reporter": "Ayşe Çelik", "date": "2025-10-02", "status": "Yeni", "location": "İzmir, Bornova", "violation_type": "Huzur İhlali", "media_type": "Image", "details": "Gece geç saatlere kadar yüksek sesli müzik."},
    ];

    final filteredData = dummyData.where((item) => item["status"] == status).toList();

    if (filteredData.isEmpty) {
      return Center(
        child: Text(
          "Bu kategoride ihbar bulunmamaktadır.",
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        return _buildIhbarCard(context, filteredData[index]);
      },
    );
  }


  // =================================================================
  // نافذة المعاينة الاحترافية (Modal Bottom Sheet)
  // =================================================================
  void _showIhbarDetailsModal(BuildContext context, Map<String, dynamic> ihbar) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {

            // المتغيرات لحالة النافذة
            String selectedViolation = 'Tanımsız';
            TextEditingController fineController = TextEditingController(text: '0');

            return Container(
              height: MediaQuery.of(context).size.height * 0.9, // 90% من ارتفاع الشاشة
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان وإغلاق النافذة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "İhbar Detayları (ID: ${ihbar["id"]})",
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 30),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 2),

                    // --- 1. معلومات البلاغ والمُبلِغ ---
                    _buildSectionHeader(title: "Temel Bilgiler", icon: Icons.info_outline, color: Colors.blueGrey),
                    _buildInfoRow("Başlık", ihbar["title"] as String, Icons.title),
                    _buildInfoRow("Bildiren", ihbar["reporter"] as String, Icons.person_rounded),
                    _buildInfoRow("Tarih", ihbar["date"] as String, Icons.calendar_today),
                    _buildInfoRow("Mevcut Durum", ihbar["status"] as String, Icons.policy_rounded),

                    const SizedBox(height: 15),
                    const Text("Detaylı Açıklama:", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(ihbar["details"] as String, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 30),

                    // --- 2. محتوى الوسائط والموقع ---
                    _buildSectionHeader(title: "Medya ve Konum", icon: Icons.location_on_outlined, color: Colors.orange),

                    // محتوى الوسائط (صورة/فيديو وهمي)
                    Text("Medya Tipi: ${ihbar["media_type"]}", style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: (ihbar["media_type"] == "Image")
                          ? const Icon(Icons.image_outlined, size: 80, color: Colors.grey)
                          : const Icon(Icons.videocam_outlined, size: 80, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),

                    // الموقع (خريطة وهمية)
                    Text("Konum: ${ihbar["location"]}", style: const TextStyle(fontWeight: FontWeight.w600)),
                    Container(
                      height: 150,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text("Konum Haritası\n(${ihbar["location"]})", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue.shade700)),
                    ),
                    const SizedBox(height: 40),

                    // --- 3. تحديد المخالفة والقرار (Decision Making) ---
                    _buildSectionHeader(title: "Karar ve Yaptırım", icon: Icons.gavel_rounded, color: Colors.red),

                    // اختيار نوع المخالفة (Drop Down)
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Seçilen İhlal Tipi",
                        prefixIcon: Icon(Icons.category, color: Colors.red),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFFFFF5F5),
                      ),
                      value: selectedViolation,
                      items: ['Tanımsız', 'Çevre İhlali', 'Altyapı Arızası', 'Trafik İhlali', 'Huzur İhlali', 'Diğer']
                          .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedViolation = value!;
                          // TODO: منطق لربط قيمة الغرامة بنوع المخالفة
                          if (value == 'Trafik İhlali') {
                            fineController.text = '500';
                          } else if (value == 'Çevre İhlali') {
                            fineController.text = '250';
                          } else {
                            fineController.text = '0';
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 15),

                    // قيمة الغرامة (Fine Amount)
                    TextField(
                      controller: fineController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Para Cezası Tutarı (₺)",
                        prefixIcon: Icon(Icons.money_outlined, color: Colors.green),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFFF5FFF5),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ملاحظات المدير
                    const TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Yönetici Notları / Açıklama",
                        hintText: "Kararı destekleyen notlarınızı buraya yazın...",
                        prefixIcon: Icon(Icons.notes),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFFF5F5F5),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // --- 4. أزرار القرار النهائي ---
                    Row(
                      children: [
                        // زر الرفض
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _processDecision(context, ihbar["id"] as String, "Reddedildi", selectedViolation);
                            },
                            icon: const Icon(Icons.thumb_down_off_alt, color: Colors.white),
                            label: const Text("Reddet", style: TextStyle(fontSize: 18, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // زر الاعتماد (التنفيذ)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _processDecision(context, ihbar["id"] as String, "Onaylandı", selectedViolation);
                            },
                            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                            label: const Text("Onayla / Kapat", style: TextStyle(fontSize: 18, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

  // دالة مساعدة لعرض صف معلومات
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue.shade700),
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

  // دالة مساعدة لعنوان القسم
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

  // دالة تنفيذ القرار
  void _processDecision(BuildContext context, String id, String decision, String violation) {
    Navigator.pop(context); // إغلاق النافذة
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("İhbar $id için karar kaydedildi: $decision. İhlal Tipi: $violation"),
        backgroundColor: (decision == "Onaylandı" || decision == "Tamamlandı") ? Colors.green.shade600 : Colors.red.shade600,
        duration: const Duration(seconds: 3),
      ),
    );
    // TODO: إضافة منطق لإرسال القرار والبيانات الجديدة إلى API وتحديث واجهة المستخدم
  }
}