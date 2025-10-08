// raporlar_page.dart (Sistem Yönetimi - Yönetici Ayarları)

import 'package:flutter/material.dart';

// ==================== Sistem Yönetimi ve Yapılandırma Sayfası ====================

class RaporlarPage extends StatelessWidget {
  const RaporlarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // Sekme Başlıkları (Tab Bar)
          TabBar(
            indicatorColor: Colors.deepOrange,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: const [
              Tab(icon: Icon(Icons.gavel_rounded), text: "İhlal Cezaları"),
              Tab(icon: Icon(Icons.pie_chart_rounded), text: "Oran Ayarları"),
            ],
          ),

          // Sekme İçerikleri (Tab Bar View)
          const Expanded(
            child: TabBarView(
              children: [
                _IhlalYonetimiTab(),
                _GlobalAyarTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== 1. İhlal Türü ve Ceza Yönetimi Sekmesi ====================
class _IhlalYonetimiTab extends StatelessWidget {
  const _IhlalYonetimiTab();

  final List<Map<String, dynamic>> _violationsData = const [
    {"id": 1, "name": "Çevre Kirliliği", "defaultFine": 350.0, "isPunishable": true, "color": Colors.green},
    {"id": 2, "name": "Trafik İhlali", "defaultFine": 500.0, "isPunishable": true, "color": Colors.red},
    {"id": 3, "name": "Gürültü Kirliliği", "defaultFine": 200.0, "isPunishable": true, "color": Colors.orange},
    {"id": 4, "name": "Altyapı Arızası", "defaultFine": 0.0, "isPunishable": false, "color": Colors.blue},
    {"id": 5, "name": "Belgesiz İnşaat", "defaultFine": 1500.0, "isPunishable": true, "color": Colors.purple},
  ];

  Widget _buildViolationCard(BuildContext context, Map<String, dynamic> violation) {
    final bool hasFine = violation["isPunishable"] as bool;
    final MaterialColor color = violation["color"] as MaterialColor;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: color.withOpacity(0.5), width: 1.5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(hasFine ? Icons.gavel_rounded : Icons.info_outline, color: color),
        ),
        title: Text(
          violation["name"] as String,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          hasFine
              ? "Ceza: ${violation["defaultFine"]} ₺"
              : "Ceza Yok (Bilgi)",
          style: TextStyle(color: hasFine ? Colors.black87 : Colors.grey.shade600),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.indigo, size: 30),
          onPressed: () => _showEditModal(context, violation),
        ),
        onTap: () => _showEditModal(context, violation),
      ),
    );
  }

  void _showEditModal(BuildContext context, Map<String, dynamic> violation) {
    TextEditingController fineController = TextEditingController(text: violation["defaultFine"].toString());
    TextEditingController nameController = TextEditingController(text: violation["name"].toString());
    bool isPunishable = violation["isPunishable"] as bool;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (stfContext, setState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("İhlal Düzenle", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
                    const Divider(height: 20),

                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "İhlal Adı",
                        prefixIcon: Icon(Icons.label_important),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),

                    TextField(
                      controller: fineController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Para Cezası (₺)",
                        prefixIcon: Icon(Icons.money_off, color: isPunishable ? Colors.green : Colors.grey),
                        border: const OutlineInputBorder(),
                        enabled: isPunishable,
                      ),
                    ),
                    const SizedBox(height: 15),

                    SwitchListTile(
                      title: const Text("Ceza Uygula"),
                      subtitle: Text(isPunishable ? "Aktif" : "Pasif"),
                      value: isPunishable,
                      onChanged: (bool value) {
                        setState(() {
                          isPunishable = value;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${nameController.text} güncellendi.")),
                          );
                        },
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: const Text("Kaydet", style: TextStyle(fontSize: 18, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "İhlal ve Ceza Yönetimi",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.deepOrange),
          ),
          const Divider(thickness: 2, height: 20),

          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Yeni İhlal Ekle")),
                );
              },
              icon: const Icon(Icons.add_circle, color: Colors.white),
              label: const Text("Yeni İhlal Ekle", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            "Mevcut İhlaller (5 Tür)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          ..._violationsData.map((v) => _buildViolationCard(context, v)).toList(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ==================== 2. Global Oran Ayarları Sekmesi ====================
class _GlobalAyarTab extends StatelessWidget {
  const _GlobalAyarTab();

  Widget _buildPercentageSlider(BuildContext context, String title, String subtitle, double initialValue, MaterialColor color) {
    double currentValue = initialValue;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 15),

            StatefulBuilder(
              builder: (stfContext, setState) {
                return Column(
                  children: [
                    Text(
                      "${currentValue.toStringAsFixed(0)} %",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
                    ),
                    Slider(
                      value: currentValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: currentValue.round().toString(),
                      activeColor: color,
                      onChanged: (double newValue) {
                        setState(() {
                          currentValue = newValue;
                        });
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$title oranı kaydedildi.")),
                          );
                        },
                        icon: const Icon(Icons.save_rounded, color: Colors.white, size: 20),
                        label: const Text("Kaydet", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(backgroundColor: color),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Global Ayarlar",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.indigo),
          ),
          const Divider(thickness: 2, height: 20),

          const SizedBox(height: 10),

          _buildPercentageSlider(
            context,
            "Otomatik Onay Eşiği",
            "Güvenilirlik puanı bu oranın üzerindeki ihbarlar otomatik onaylanır.",
            85.0,
            Colors.teal,
          ),

          _buildPercentageSlider(
            context,
            "Gecikme Cezası Zammı",
            "Ödeme geciktiğinde uygulanacak ek yüzde oranı.",
            15.0,
            Colors.red,
          ),

          _buildPercentageSlider(
            context,
            "Bildiren Güven Ağırlığı",
            "Kullanıcı güven skorunun ihbar güvenilirliğine etkisi.",
            40.0,
            Colors.purple,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}