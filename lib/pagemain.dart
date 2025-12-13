import 'package:flutter/material.dart';
// ใช้ Material Widgets ของ Flutter เช่น Scaffold, NavigationBar, TextField, Card, ListTile, Checkbox

// ------------------------------------
// PageMain เป็น StatefulWidget
// เพราะในหน้านี้มีข้อมูลเปลี่ยนแปลงได้ (เพิ่มงาน, ติ๊กงาน, ลบงาน, สลับหน้า)
// ------------------------------------
class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

// ------------------------------------
// _PageMainState คือ state (ข้อมูล + UI) ของ PageMain
// ------------------------------------
class _PageMainState extends State<PageMain> {

  // ------------------------------------
  // TextEditingController ใช้ควบคุม/อ่านค่าจาก TextField
  // topic = ช่องกรอกหัวข้อ, desc = ช่องกรอกรายละเอียด
  // ------------------------------------
  TextEditingController topic = TextEditingController();
  TextEditingController desc = TextEditingController();

  // ------------------------------------
  // todoList เก็บรายการงานทั้งหมด
  // แต่ละงานเป็น Map เช่น:
  // { "title": "...", "desc": "...", "done": true/false }
  // ------------------------------------
  List<Map<String, dynamic>> todoList = [];

  // ------------------------------------
  // currentPageIndex ใช้สลับหน้าใน NavigationBar
  // 0 = หน้าเพิ่มงาน (Add)
  // 1 = หน้าแสดงรายการงาน (Tasks)
  // ------------------------------------
  int currentPageIndex = 0;

  // ------------------------------------
  // addTodo() : ฟังก์ชันเพิ่มงานใหม่เข้ารายการ
  // - ตรวจว่า input ว่างไหม
  // - ถ้าไม่ว่าง -> เพิ่มเข้า todoList และล้างช่องกรอก
  // - ใช้ setState() เพื่อให้ UI รีเฟรช
  // ------------------------------------
  void addTodo() {
    // trim() คือการตัดช่องว่างหัว-ท้าย เช่น "  abc  " => "abc"
    if (topic.text.trim().isEmpty || desc.text.trim().isEmpty) {
      print("กรอกข้อมูลไม่ครบ"); // แสดงใน debug console
      return; // หยุดทำงานทันที ไม่เพิ่มงาน
    }

    setState(() {
      // เพิ่มงานใหม่เข้า List
      todoList.add({
        "title": topic.text.trim(),
        "desc": desc.text.trim(),
        "done": false, // งานใหม่ยังไม่เสร็จ
      });
    });

    print("เพิ่มงาน: ${topic.text.trim()}"); // แสดงใน debug console
    topic.clear(); // ล้างช่องหัวข้อ
    desc.clear();  // ล้างช่องรายละเอียด
  }

  // ------------------------------------
  // pageAdd() : สร้างหน้าสำหรับ "เพิ่มงาน"
  // ใช้ ListView เพื่อเลื่อนลงได้ (เผื่อจอเล็ก)
  // ในหน้านี้มี:
  // - Text (หัวข้อ TO DO LIST)
  // - TextField 2 ช่อง (หัวข้อ/รายละเอียด)
  // - ElevatedButton (ปุ่มเพิ่มงาน)
  // ------------------------------------
  Widget pageAdd() {
    return ListView(
      padding: EdgeInsets.all(16), // ระยะห่างขอบรอบๆ
      children: [
        Text(
          "TO DO LIST",
          textAlign: TextAlign.center, // ตัวอักษรอยู่กลาง
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16), // เว้นระยะห่างแนวตั้ง

        // ------------------------------------
        // (Widget #2) TextField: ช่องกรอกหัวข้อ
        // controller: topic = เอาค่าที่พิมพ์ไปเก็บใน topic
        // decoration: ตกแต่งให้มี label, สีพื้นหลัง, ไอคอน, ขอบมน
        // ------------------------------------
        TextField(
          controller: topic,
          onChanged: (val){
          print("หัวข้อ $val");
          // showText_3 = val;
        },
          decoration: InputDecoration(
            labelText: "หัวข้อ",
            filled: true,
            fillColor: Color(0xFFFFDF6D),
            prefixIcon: Icon(Icons.list),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 12),

        // ------------------------------------
        // (Widget #2) TextField: ช่องกรอกรายละเอียด (หลายบรรทัด)
        // minLines: 3 = เริ่มต้นสูง 3 บรรทัด
        // maxLines: null = พิมพ์ได้หลายบรรทัดแบบขยาย
        // ------------------------------------
        TextField(
          controller: desc,
          onChanged: (val){
          print("รายละเอียด $val");
          // showText_3 = val;
        },
          minLines: 3,
          maxLines: null,
          decoration: InputDecoration(
            labelText: "รายละเอียด",
            filled: true,
            fillColor: Color(0xFFFFDF6D),
            prefixIcon: Icon(Icons.notes),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 12),

        // ------------------------------------
        // ElevatedButton: ปุ่มกดเพิ่มงาน
        // onPressed: addTodo = กดแล้วเรียกฟังก์ชัน addTodo()
        // ------------------------------------
        ElevatedButton(
          onPressed: addTodo,
          child: Text("เพิ่มงาน"),
        ),
      ],
    );
  }

  // ------------------------------------
  // pageList() : หน้าสำหรับแสดงรายการงานทั้งหมด
  // ถ้า todoList ว่าง -> แสดงข้อความ
  // ถ้ามีงาน -> ใช้ ListView.builder สร้างรายการตามจำนวนงาน
  // ------------------------------------
  Widget pageList() {
    if (todoList.isEmpty) {
      return Center(child: Text("ยังไม่มีงานที่ต้องทำ"));
    }

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: todoList.length, // จำนวนงานทั้งหมด
      itemBuilder: (context, index) {
        var item = todoList[index]; // งานแต่ละตัว

        // ------------------------------------
        // (Widget #5) Card: ทำให้ 1 งานอยู่ในกล่องสวยๆ
        // ------------------------------------
        return Card(
          child:
              // ------------------------------------
              // (Widget #4) ListTile: แถวรายการสำเร็จรูป
              // มี leading/title/subtitle/trailing
              // ------------------------------------
              ListTile(

            // ------------------------------------
            // (Widget #3) Checkbox: ติ๊กงานเสร็จ/ไม่เสร็จ
            // value: item["done"] = อ่านค่าสถานะ
            // onChanged: เปลี่ยนค่า done แล้ว setState เพื่อรีเฟรช UI
            // ------------------------------------
            leading: Checkbox(
              value: item["done"],
              onChanged: (val) {
                setState(() {
                  item["done"] = val == true;
                });
                print("สถานะงาน #$index : ${item["done"]}");
              },
            ),

            // title: ชื่องาน
            // ถ้า done == true -> ขีดฆ่า (lineThrough)
            title: Text(
              item["title"],
              style: TextStyle(
                decoration: item["done"] ? TextDecoration.lineThrough : null,
              ),
            ),

            // subtitle: รายละเอียดงาน
            subtitle: Text(item["desc"]),

            // trailing: ปุ่มลบ
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                print("ลบงาน #$index : ${item["title"]}");
                setState(() {
                  todoList.removeAt(index); // ลบงานตาม index
                });
              },
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------
  // build() : ส่วนสร้างหน้าจอหลัก
  // ใช้ Scaffold เป็นโครงหน้า
  // bottomNavigationBar = แถบเมนูด้านล่าง
  // body = เนื้อหา เปลี่ยนตาม currentPageIndex
  // ------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ------------------------------------
      // (Widget #1) NavigationBar: สลับหน้า Add / Tasks
      // selectedIndex: หน้าไหนถูกเลือก
      // onDestinationSelected: กดแล้วเปลี่ยน currentPageIndex
      // ------------------------------------
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
          print("เปลี่ยนหน้า = $index");
        },

        // destinations: ปุ่มเมนูใน NavigationBar
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.edit_note),
            label: "Add",
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: "Tasks",
          ),
        ],
      ),

      // SafeArea กัน UI ชนขอบจอ/รอยบาก
      body: SafeArea(
        // ใช้ List ของหน้า 2 หน้า แล้วเลือกด้วย currentPageIndex
        child: [
          pageAdd(),  // index 0
          pageList(), // index 1
        ][currentPageIndex],
      ),
    );
  }
}
