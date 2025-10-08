import 'package:flutter/material.dart';
import '../../widgets/stat_card.dart';     // المسار: widgets/
import '../../widgets/action_card.dart';  // المسار: widgets/

// ==================== Dashboard (Ana Panel) - Geliştirilmiş ====================
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Yönetici Özet Paneli",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
          const Divider(height: 30),

          // **قسم 1: بطاقات الإحصاءات (باستخدام StatCard)**
          Row(
            children: [
              Expanded(
                child: StatCard(
                    icon: Icons.people_alt,
                    title: "Toplam Kullanıcı",
                    value: "1.247",
                    color: Colors.blue
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: StatCard(
                    icon: Icons.report_problem,
                    title: "Açık İhbar",
                    value: "45",
                    color: Colors.red
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: StatCard(
                    icon: Icons.attach_money,
                    title: "Kesilen Ceza",
                    value: "₺45K",
                    color: Colors.green
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: StatCard(
                    icon: Icons.check_circle_outline,
                    title: "Çözülen İhbar",
                    value: "3411",
                    color: Colors.orange
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // **قسم 2: منطقة المخطط البياني (Trend Chart Placeholder)**
          const Text("Aylık İhbar Trendi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 10),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Yer Tutucu: Son 6 Aylık İhbar Grafiği",
                style: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.italic),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // **قسم 3: آخر الإشعارات (باستخدام ActionCard)**
          const Text("Son İhbarlar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 10),

          ActionCard(
            icon: Icons.directions_car,
            title: "Yanlış Park Cezası",
            subtitle: "Bölge: Kadıköy | Durum: Yeni",
            color: Colors.red,
            trailingWidget: const Text("₺750", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            onTap: () {},
          ),
          ActionCard(
            icon: Icons.eco,
            title: "Çevre Kirliliği Bildirimi",
            subtitle: "Bölge: Beşiktaş | Durum: İnceleniyor",
            color: Colors.green,
            trailingWidget: const Icon(Icons.access_time, color: Colors.orange),
            onTap: () {},
          ),
          ActionCard(
            icon: Icons.campaign,
            title: "Gürültü Kirliliği",
            subtitle: "Bölge: Fatih | Durum: Tamamlandı",
            color: Colors.blueGrey,
            trailingWidget: const Icon(Icons.check, color: Colors.green),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}