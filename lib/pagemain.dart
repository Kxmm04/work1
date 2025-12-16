import 'package:flutter/material.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  bool status = false;
  String result = "ยังไม่เปิดใช้งาน";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),

      appBar: AppBar(
        title: Text("Widget Demo"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        foregroundColor: Color.fromARGB(255, 60, 60, 60),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Switch (Material Widget)
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SwitchListTile(
                title: Text("เปิดใช้งานระบบ"),
                subtitle: Text("กดเพื่อเปิดหรือปิด"),
                value: status,
                onChanged: (val) {
                  setState(() {
                    status = val;
                    result = val ? "ระบบเปิดใช้งาน" : "ระบบปิดอยู่";
                  });
                  print("สถานะ Switch: $status");
                },
              ),
            ),

            SizedBox(height: 20),

            // 🔹 ปุ่มยืนยัน
            ElevatedButton.icon(
              onPressed: () {
                print("กดปุ่มยืนยัน");
                print("ผลลัพธ์: $result");

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              },
              icon: Icon(Icons.check),
              label: Text("ยืนยัน"),
            ),

            SizedBox(height: 20),

            // 🔹 Card แสดงผล
            Card(
              color: Color.fromARGB(255, 245, 245, 245),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(width: 8),
                    Text("ผลลัพธ์: $result"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
