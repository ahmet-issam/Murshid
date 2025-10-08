import 'package:flutter/material.dart';

// ==================== Yeni İhbar Formu Sayfası ====================
class NewIhbarPage extends StatefulWidget {
  const NewIhbarPage({super.key});

  @override
  State<NewIhbarPage> createState() => _NewIhbarPageState();
}

class _NewIhbarPageState extends State<NewIhbarPage> {
  String? _selectedCategory;
  String? _photoPath; // Seçilen fotoğrafın yolunu tutmak için

  // İhbar kategorileri (Örnek veriler)
  final List<String> _categories = [
    'Çevre Kirliliği',
    'Yol Hasarı',
    'Gürültü Şikayeti',
    'Belediye Hizmetleri',
    'Diğer',
  ];

  void _pickMedia() {
    // Gerçek uygulamada kamera veya galeri açılacaktır.
    setState(() {
      _photoPath = "assets/images/dummy_photo.jpg"; // Dummy bir değer atandı
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Medya seçimi başarılı! (Örnek: Fotoğraf)")),
    );
  }

  void _submitIhbar() {
    if (_photoPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen ihbarınıza ait bir fotoğraf veya video ekleyin.", style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
      );
      return;
    }
    // TODO: Form verilerini topla ve API'ye gönder

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("İhbarınız başarıyla alındı ve yönetici onayına gönderildi!", style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
    );
    Navigator.pop(context); // Gönderimden sonra sayfayı kapat
  }

  // Yardımcı widget: Medya Yükleme Alanı
  Widget _buildMediaUploadArea() {
    return InkWell(
      onTap: _pickMedia,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _photoPath == null ? Colors.red.shade300 : Colors.green.shade500,
            width: 2,
            style: BorderStyle.solid, // <-- DÜZELTME: 'solid' olarak değiştirildi
          ),
        ),
        child: _photoPath == null
            ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, color: Colors.blue, size: 40),
            SizedBox(height: 8),
            Text("Fotoğraf/Video Ekle", style: TextStyle(color: Colors.blueGrey)),
            Text("(Zorunlu)", style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        )
            : const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 5),
            Text("Medya Eklendi!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni İhbar Formu"),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Medya Yükleme Alanı
            const Text(
              "1. İhbar Medyası (Fotoğraf/Video)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 15),
            _buildMediaUploadArea(),
            const SizedBox(height: 30),

            // 2. Kategori Seçimi
            const Text(
              "2. İhbar Kategorisi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 15),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Kategori Seçin",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category, color: Colors.blueGrey),
              ),
              value: _selectedCategory,
              hint: const Text("Lütfen bir kategori seçiniz..."),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 30),

            // 3. Konum Belirleme
            const Text(
              "3. Konum Bilgisi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 15),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.green),
              title: const Text("Mevcut Konumu Belirle"),
              subtitle: const Text("Konum: 41.0000, 28.0000 (Otomatik Alındı)"),
              trailing: const Icon(Icons.refresh),
              onTap: () {
                // TODO: GPS verilerini yenile
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.green.shade200),
              ),
            ),
            const SizedBox(height: 30),

            // 4. İhbar Detayı (Açıklama)
            const Text(
              "4. Detaylı Açıklama",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 15),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "İhbarınızı detaylıca açıklayın",
                hintText: "Örn: Cadde üzerindeki çöp yığılması 3 gündür alınmadı.",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),

            // Gönder Butonu
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _submitIhbar,
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text(
                  "İhbarı Gönder",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}