import 'package:flutter/material.dart';
import '../../widgets/action_card.dart'; // المسار: widgets/

// ==================== Analytics Page (Analiz) - Geliştirılmış ====================
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  Widget _analyticsCard(IconData icon, String title, String subtitle, Color color) {
    return ActionCard(
      icon: icon,
      title: title,
      subtitle: subtitle,
      color: color,
      trailingWidget: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      onTap: () {
        // TODO: Detaylı Analiz Sayfasına Git
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        // قسم المخطط البياني (Placeholder)
        const Text(
            "Genel İhbar Dağılımı",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)
        ),
        const SizedBox(height: 15),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: const Center(
            child: Text(
              "Placeholder: Grafik Verisi Buraya Gelecek\n(Örn: Bar Chart, Pie Chart)",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 30),

        // قسم المقاييس الرئيسية (KPI)
        const Text(
            "Önemli Performans Göstergeleri (KPI)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)
        ),
        const SizedBox(height: 15),

        // بطاقات المقاييس الرئيسية (باستخدام ActionCard)
        _analyticsCard(
            Icons.done_all,
            "Tamamlanan İhbar Sayısı",
            "Toplam: 1250",
            Colors.green
        ),
        _analyticsCard(
            Icons.access_time,
            "Ortalama Çözüm Süresi",
            "2.3 Gün",
            Colors.orange
        ),
        _analyticsCard(
            Icons.warning,
            "Açık İhbarlar (Yüksek Öncelik)",
            "58 Adet",
            Colors.red
        ),

        const SizedBox(height: 30),

        // قسم تقارير التفاصيل
        const Text(
            "Detaylı Rapor Alanları",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)
        ),
        const SizedBox(height: 15),

        // بطاقات التفاصيل الأصلية (باستخدام ActionCard)
        _analyticsCard(
            Icons.location_on,
            "Bölgesel Yoğunluk",
            "En çok ihbar: İstanbul (%45)",
            Colors.deepPurple
        ),
        _analyticsCard(
            Icons.trending_up,
            "Aylık İhbar Trendi",
            "Son 3 ayda %15 artış",
            Colors.teal
        ),
        _analyticsCard(
            Icons.person,
            "En Aktif Kullanıcı",
            "Kullanıcı ID: #007 (42 İhbar)",
            Colors.indigo
        ),
      ],
    );
  }
}