import 'package:flutter/material.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  TextEditingController input = TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // สีพื้นหลังหน้า
      backgroundColor: Color.fromARGB(255, 250, 250, 250),

      appBar: AppBar(
        title: Text("Wiget Demo"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        foregroundColor: Color.fromARGB(255, 60, 60, 60),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 ช่องกรอกข้อความ
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: TextFormField(
                controller: input,
                onChanged: (value) {
                  print("พิมพ์ข้อความ: $value");
                },
                decoration: InputDecoration(
                  hintText: "กรอกข้อความ",
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                  contentPadding: EdgeInsets.fromLTRB(20, 12, 10, 12),
                  prefixIcon: Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 120, 120, 120),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // 🔹 ปุ่มบันทึก
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 200, 200, 200),
                  foregroundColor: Color.fromARGB(255, 60, 60, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                onPressed: () {
                  // 🔍 เช็คค่าว่าง
                  if (input.text.trim().isEmpty) {
                    print("ยังไม่ได้กรอกข้อความ");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("กรุณากรอกข้อความก่อนบันทึก")),
                    );
                    return;
                  }

                  setState(() {
                    result = input.text;
                  });

                  print("บันทึกคำตอบ: ${input.text}");
                  print("ผลลัพธ์ที่แสดง: $result");

                  // ✅ แสดง SnackBar (Material Widget)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("บันทึกข้อมูลเรียบร้อย")),
                  );

                  input.clear();
                },

                icon: Icon(Icons.save),
                label: Text("บันทึก"),
              ),
            ),

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
                    Icon(
                      Icons.bookmark,
                      color: Color.fromARGB(255, 100, 100, 100),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "ผลลัพธ์: $result",
                      style: TextStyle(color: Color.fromARGB(255, 50, 50, 50)),
                    ),
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
