/*
how to show this data,
you show this data in my below requirements,
first open application then show top two dropdown page first "Select Class" and Second "Select Date".
now, user click 'Select Class" then show all class after user select class then user select date then show
selected class and selected date data Using getx.


I have created flutter application
I want to I am fetching this data,
So you create model class



this is function used I have fetched data : "Future<void> loadStudentsData() async {
    try {
      String data = await rootBundle.loadString('assets/homework.json');
      List<dynamic> jsonList = json.decode(data);

      homework.value = jsonList.map((e) => Homework.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data');
    }
  }
"

*/