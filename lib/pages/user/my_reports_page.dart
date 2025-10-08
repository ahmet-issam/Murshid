import 'package:flutter/material.dart';

// ==================== Kullanıcının İhbarlarını Takip Sayfası ====================
class MyReportsPage extends StatelessWidget {
  const MyReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İhbar Takip Merkezi"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      // TabBar Controller ile ihbarları duruma göre ayırıyoruz
      body: const DefaultTabController(
        length: 3, // İşlemde, Tamamlandı, Reddedildi
        child: Column(
          children: [
            // Sekme Başlıkları (TabBar)
            TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "İşlemde"),
                Tab(text: "Tamamlandı"),
                Tab(text: "Reddedildi"),
              ],
            ),

            // Sekme İçerikleri (TabBarView)
            Expanded(
              child: TabBarView(
                children: [
                  // 1. İşlemdeki İhbarlar
                  _ReportList(status: "İşlemde"),
                  // 2. Tamamlanan İhbarlar
                  _ReportList(status: "Tamamlandı"),
                  // 3. Reddedilen İhbarlar
                  _ReportList(status: "Reddedildi"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== İhbar Listesini Gösteren Yardımcı Widget ====================
class _ReportList extends StatelessWidget {
  final String status;

  const _ReportList({required this.status});

  // Durum Stili Fonksiyonu
  Map<String, dynamic> _getStatusStyle(String status) {
    switch (status) {
      case "İşlemde":
        return {"color": Colors.orange, "text": "İşlemde", "icon": Icons.access_time};
      case "Tamamlandı":
        return {"color": Colors.green, "text": "Tamamlandı", "icon": Icons.check_circle};
      case "Reddedildi":
        return {"color": Colors.red, "text": "Reddedildi", "icon": Icons.cancel};
      default:
        return {"color": Colors.grey, "text": "Bilinmiyor", "icon": Icons.help_outline};
    }
  }

  // İhbar Kartı Oluşturma Fonksiyonu
  Widget _buildReportTile(BuildContext context, String id, String title, String date, String status, String coverage) {
    final style = _getStatusStyle(status);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        leading: Icon(style["icon"], color: style["color"], size: 30),
        title: Text(
          "$title (ID: $id)",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Bildirim Tarihi: $date"),
            if (status == "Tamamlandı") Text("Kapsama Oranı: %$coverage", style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w600)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: style["color"].withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            style["text"],
            style: TextStyle(color: style["color"], fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        onTap: () {
          // TODO: İhbar detaylarını gösteren sayfaya git
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("ID $id numaralı ihbarın detayları açılıyor.")),
          );
        },
      ),
    );
  }

  // Liste Oluşturma (Dummy Data ile)
  @override
  Widget build(BuildContext context) {
    // Dummy veriler (Kullanıcının gönderdiği ihbarlar)
    final List<Map<String, String>> dummyData = [
      {"id": "001", "title": "Çöp Yığılması", "date": "2025-10-01", "status": "İşlemde", "coverage": "0"},
      {"id": "002", "title": "Bozuk Aydınlatma", "date": "2025-09-28", "status": "Tamamlandı", "coverage": "100"},
      {"id": "003", "title": "Yol Hasarı", "date": "2025-09-20", "status": "Tamamlandı", "coverage": "75"},
      {"id": "004", "title": "Gürültü Kirliliği", "date": "2025-10-02", "status": "İşlemde", "coverage": "0"},
      {"id": "005", "title": "Park İhlali", "date": "2025-09-29", "status": "Reddedildi", "coverage": "0"},
      {"id": "006", "title": "Su Borusu Sızıntısı", "date": "2025-10-03", "status": "İşlemde", "coverage": "0"},
    ];

    // Verileri mevcut sekmeye göre filtrele
    final filteredData = dummyData.where((item) => item["status"] == status).toList();

    if (filteredData.isEmpty) {
      return Center(
        child: Text(
          "Bu durumda ( $status ) ihbarınız bulunmamaktadır.",
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];
        return _buildReportTile(
          context,
          item["id"]!,
          item["title"]!,
          item["date"]!,
          item["status"]!,
          item["coverage"]!,
        );
      },
    );
  }
}