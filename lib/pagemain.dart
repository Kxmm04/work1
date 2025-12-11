import 'package:flutter/material.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  TextEditingController topic = TextEditingController();
  TextEditingController desc = TextEditingController();
  // เก็บ index ของหน้าปัจจุบัน (0 = Home, 1 = Notifications, 2 = Messages)
  int currentPageIndex = 0;

  Widget label1() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "TO DO LIST ",
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: 'Prompt',
        ),
      ),
      padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
    );
  }

  Widget label2() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "หัวข้อ",
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Prompt',
        ),
      ),
      padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
    );
  }

  Widget label3() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "รายละเอียด",
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Prompt',
        ),
      ),
      padding: EdgeInsets.fromLTRB(16, 20, 0, 0),
    );
  }

  Widget textInput_topic() {
    return Container(
      child: TextFormField(
        controller: topic,
        onChanged: (val) {
          print("onChanged $val");
          // showText_3 = val;
        },
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 255, 223, 109),
          filled: true,
          hintText: 'หัวข้อที่ต้องการ',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
          prefixIcon: Icon(Icons.list, color: Color.fromARGB(255, 0, 0, 0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none, // ไม่เอาเส้นขอบ
            // borderSide: BorderSide(width: 10,color: Color.fromARGB(255, 245, 3, 213))
          ),
        ),
      ),
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
    );
  }

  Widget textInput_desc() {
    return Container(
      child: TextFormField(
        minLines: 4, // 🔥 ความสูงขั้นต่ำ (กล่องใหญ่ขึ้น)
        maxLines: null, // 🔥 พิมพ์ได้หลายบรรทัด
        controller: desc,
        onChanged: (val) {
          print("onChanged $val");
          // showText_3 = val;
        },
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 255, 223, 109),
          filled: true,
          hintText: 'รายละเอียด',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
          prefixIcon: Icon(Icons.list, color: Color.fromARGB(255, 0, 0, 0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none, // ไม่เอาเส้นขอบ
            // borderSide: BorderSide(width: 10,color: Color.fromARGB(255, 245, 3, 213))
          ),
        ),
      ),
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      // --------------------------
      // ⬇️ NavigationBar ด้านล่าง
      // --------------------------
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index; // เปลี่ยนหน้า
          });
        },
        indicatorColor: const Color.fromARGB(255, 0, 123, 255),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home), // ไอคอนที่แสดงเมื่อเลือก
            icon: Icon(Icons.home_outlined), // ไอคอนที่แสดงเมื่อไม่เลือกห
            label: 'Home', // ชื่อ
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),

      // --------------------------
      // ⬇️ เนื้อหาหน้าจอ (body)
      // เลือกหน้าตาม currentPageIndex
      // --------------------------
      body: SafeArea(
        child: <Widget>[
          /// Home page
          Center(
            child: ListView(
              children: [
                label1(),
                label2(),
                textInput_topic(),
                label3(),
                textInput_desc(),
                Text("T5"),
              ],
            ),
          ),

          /// Notifications page
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.notifications_sharp),
                    title: Text('Notification 1'),
                    subtitle: Text('This is a notification'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.notifications_sharp),
                    title: Text('Notification 2'),
                    subtitle: Text('This is a notification'),
                  ),
                ),
              ],
            ),
          ),

          /// Messages page
          ListView.builder(
            reverse: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Hello',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
              }
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hi!',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              );
            },
          ),
        ][currentPageIndex], //// <<<< ดึงหน้าออกมาตาม index
      ),
    );
  }
}
