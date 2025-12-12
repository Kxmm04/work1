import 'package:flutter/material.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  TextEditingController topic = TextEditingController();
  TextEditingController desc = TextEditingController();

  // ใช้ dynamic เพราะมีทั้ง String และ bool
  List<Map<String, dynamic>> todoList = []; // <-- เก็บ To-Do ทั้งหมด

  int currentPageIndex = 0;

  // เพิ่มงานเข้า List
  void addTodo() {
    if (topic.text.isNotEmpty && desc.text.isNotEmpty) {
      setState(() {
        todoList.add({
          "title": topic.text,
          "desc": desc.text,
          "done": false, // งานใหม่ยังไม่เสร็จ
        });
      });

      topic.clear();
      desc.clear();
    }
  }

  // ------------------------------------------------------------------
  // วิดเจ็ตหัว TO DO LIST
  // ------------------------------------------------------------------
  Widget titleHeader() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 20),
      child: const Text(
        "TO DO LIST",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
      ),
    );
  }

  // ช่องกรอก "หัวข้อ + รายละเอียด + ปุ่มบันทึก"
  Widget inputArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // กรอกหัวข้อ
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            "หัวข้อ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: topic,
            decoration: InputDecoration(
              hintText: 'หัวข้อที่ต้องการ',
              filled: true,
              fillColor: const Color(0xFFFFDF6D),
              prefixIcon: const Icon(Icons.list),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // กรอกรายละเอียด
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            "รายละเอียด",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: desc,
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'รายละเอียดงาน',
              filled: true,
              fillColor: const Color(0xFFFFDF6D),
              prefixIcon: const Icon(Icons.notes),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // ปุ่มบันทึก
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
              onPressed: addTodo,
              child: const Text("เพิ่มงาน"),
            ),
          ),
        ),
      ],
    );
  }

  // แสดงรายการ To-Do (ใช้ ListTile + Checkbox)
  Widget todoListView() {
    if (todoList.isEmpty) {
      return const Center(
        child: Text(
          "ยังไม่มีงานที่ต้องทำ",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        bool done = todoList[index]["done"] as bool;

        return Card(
          child: ListTile(
            leading: Checkbox(
              value: done,
              onChanged: (value) {
                setState(() {
                  todoList[index]["done"] = value ?? false;
                });
              },
            ),
            title: Text(
              todoList[index]["title"] ?? "",
              style: TextStyle(
                fontSize: 18,
                color: done ? Colors.grey : Colors.black,
                decoration:
                    done ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            subtitle: Text(
              todoList[index]["desc"] ?? "",
              style: TextStyle(
                color: done ? Colors.grey : Colors.black,
                decoration:
                    done ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  todoList.removeAt(index);
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --------------------------------------------------------------
      // NavigationBar ด้านล่าง
      // --------------------------------------------------------------
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.list_alt),
            ),
            label: "Tasks",
          ),
        ],
      ),

      // --------------------------------------------------------------
      body: SafeArea(
        child: [
          // หน้า 0 = Add ToDo
          ListView(
            children: [
              titleHeader(),
              inputArea(),
            ],
          ),

          // หน้า 1 = Show ToDo List
          todoListView(),
        ][currentPageIndex],
      ),
    );
  }
}
