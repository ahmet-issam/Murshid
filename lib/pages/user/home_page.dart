import 'package:flutter/material.dart';

// ==================== Kullanıcı Ana Sayfası (HomePage) ====================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Yardımcı widget: İhbar Durum Kartı
  Widget _buildIhbarDurumCard(String title, String status, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, color: color, size: 35),
        title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
        ),
        subtitle: Text(
          "Durum: $status",
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          // TODO: İhbar detay sayfasına git
        },
      ),
    );
  }

  // Yardımcı widget: Genel Duyuru Kartı
  Widget _buildDuyuruCard(String title, String date) {
    return Card(
      color: Colors.blue.shade50,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.blueAccent)),
      child: ListTile(
        leading: const Icon(Icons.campaign, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(date),
        onTap: () {
          // TODO: Duyuru detayını göster
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy İhbar Verisi
    final List<Map<String, dynamic>> myIhbarlar = [
      {"title": "Çöp Yığılması", "status": "İşlemde", "icon": Icons.access_time, "color": Colors.orange},
      {"title": "Bozuk Parke Taşı", "status": "Tamamlandı", "icon": Icons.check_circle, "color": Colors.green},
      {"title": "Gürültü Şikayeti", "status": "Reddedildi", "icon": Icons.cancel, "color": Colors.red},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("MÜRŞID Mobil Uygulama"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // TODO: Profil ve Ayarlar sayfasına git
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hoş Geldiniz Mesajı ve Özet
            const Text(
              "Merhaba, Ahmet Yılmaz!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
            ),
            const Text(
              "Bildirimlerinizi takip edebilir veya yeni bir ihbar oluşturabilirsiniz.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Genel Duyurular Bölümü
            const Text(
              "Genel Duyurular",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey),
            ),
            const Divider(height: 10),
            _buildDuyuruCard("Sistem Bakımı Başarıyla Tamamlandı", "03.10.2025"),
            _buildDuyuruCard("Yeni İhbar Kategorisi Eklendi", "01.10.2025"),
            const SizedBox(height: 30),

            // Benim İhbarlarım Bölümü
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Son İhbarlarım",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Tüm ihbarları listeleme sayfasına git
                  },
                  child: const Text("Tümünü Gör", style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
            const Divider(height: 10),

            // İhbarların Listelenmesi
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: myIhbarlar.length,
              itemBuilder: (context, index) {
                final ihbar = myIhbarlar[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildIhbarDurumCard(
                    ihbar["title"],
                    ihbar["status"],
                    ihbar["icon"],
                    ihbar["color"],
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),

      // Yeni İhbar Gönderme Butonu
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Yeni İhbar Form Sayfasına git
        },
        icon: const Icon(Icons.add_a_photo, color: Colors.white),
        label: const Text("Yeni İhbar Gönder", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red.shade700,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}