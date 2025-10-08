import 'package:flutter/material.dart';

// ==================== Reusable Stat Card Widget ====================
class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final bool isCompact; // لتحديد ما إذا كانت بطاقة صغيرة (مثل صفحة المستخدمين)

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    // تنسيق مخصص للبطاقة المدمجة (Compact)
    if (isCompact) {
      return Column(
        children: [
          Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)
          ),
          const SizedBox(height: 4),
          Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey)
          ),
        ],
      );
    }

    // تنسيق البطاقة الرئيسية (Dashboard)
    return Card(
      color: color.withOpacity(0.08),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}