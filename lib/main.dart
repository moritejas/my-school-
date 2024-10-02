import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'Admin Panel/HomePage/final_sidebar.dart';
// ignore: unused_import
import 'Admin Panel/Pages/Homework/View/homework.dart';
// import 'Admin Panel/Pages/TimeTable/View/time_table.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        // scaffoldBackgroundColor: Colors.grey.shade100,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.teal.shade700,
          ),
        ),
      ),
      // home:FinalResponsiveSidebar(),
      home:HomeWorks(),
      // home:TimeTableView(),
      // home:EventsPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context)  {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          children: [
            Container(width: 200, height: 200, color: Colors.blue, margin: const EdgeInsets.all(5),),
            Container(width: 200, height: 200, color: Colors.blue, margin: const EdgeInsets.all(5),),
            Container(width: 200, height: 200, color: Colors.blue, margin: const EdgeInsets.all(5),),
            Container(width: 200, height: 200, color: Colors.blue, margin: const EdgeInsets.all(5),),
            Container(width: 200, height: 200, color: Colors.blue, margin: const EdgeInsets.all(5),),
          ],
        )
    );
  }
}