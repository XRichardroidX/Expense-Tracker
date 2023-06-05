import 'dart:async';
import 'package:flutter/material.dart';
import 'backend.dart';

String formatDuration(Duration duration) {
  // Calculate the number of days, hours, minutes, and seconds
  int days = duration.inDays;
  int hours = duration.inHours % 24;
  int minutes = duration.inMinutes % 60;
  int seconds = duration.inSeconds % 60;

  // Format the duration as a string
  String formattedDuration = '';
  if (days > 0) {
    formattedDuration += '$days day${days > 1 ? 's' : ''} ';
  }
  if (hours > 0) {
    formattedDuration += '$hours hour${hours > 1 ? 's' : ''} ';
  }
  if (minutes > 0) {
    formattedDuration += '$minutes minute${minutes > 1 ? 's' : ''} ';
  }
  if (seconds > 0) {
    formattedDuration += '$seconds second${seconds > 1 ? 's' : ''} ';
  }

  return formattedDuration.trim();
}


void main(){
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> retrievedList = [];
  List<List<dynamic>> retrievedInnerList = [[]];
  Database database = Database();

    listsOfDates() async {
    retrievedList = await database.getListOfDate();
    setState((){});
  }

  String doNothing = '';

  @override
  void initState() {
    setState(() {
      listsOfDates();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Center(
            child: Text('Cash Flow')
          ),
          elevation: 0,
        ),
        body: ListView.builder(
        itemCount: retrievedList.length,
          itemBuilder: (BuildContext context, int index) {
          return Container(
          color: Colors.white,
          child: GestureDetector(
          onTap: () {
            setState(() {
            //Todo Something
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Eachday(selectedDateIndex: index)));
          },
            onLongPress: () async {
              database.getIndex(index);
              database.clearAll();
            database.clearDateList(index);
            setState(() {});
            },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: retrievedList[index] == '' ?
            Stack()
                :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 5,
                          color: Colors.black
                      ),
                      left: BorderSide(
                          width: 5,
                          color: Colors.black
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Text('${retrievedList[index]}'),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 5,
                          color: Colors.black
                      ),
                      right: BorderSide(
                          width: 5,
                          color: Colors.black
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: const Text("View"),
                ),
              ],
            ),
          ),
        ),
         );
        },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          DateTime date = DateTime.timestamp();
          int _date = date.day;
          database.saveListOfDates(_date);
          Timer(Duration(microseconds: 2), () {
            listsOfDates();
          });
          setState(() {});
        }),
      ),
    );
  }
}

class Eachday extends StatefulWidget {
   final int selectedDateIndex;
   Eachday({Key? key, required this.selectedDateIndex}) : super(key: key);

  @override
  State<Eachday> createState() => _EachdayState();
}

class _EachdayState extends State<Eachday> {
   TextEditingController Title = TextEditingController();

   TextEditingController Amount = TextEditingController();

   Database infoObject = Database();

   List<List<dynamic>> retrievedList = [];


   void retrievedData() async {
       infoObject.getIndex(widget.selectedDateIndex);
       retrievedList = await infoObject.getList(widget.selectedDateIndex);
       setState(() {});
   }

   bool notDisplayed = true;

   @override
  void initState() {
    // TODO: implement initState
     setState(() {
       retrievedData();

     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: notDisplayed ? GestureDetector(
        onTap: (){
          setState(() {
            notDisplayed = false;
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Center(child: Text("Tap to display records"),),
        ),
      ) : Stack(
        alignment: Alignment.topCenter,
            children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 70, 10, 0),
                  child: ListView.builder(
                  itemCount: retrievedList.length,
                  itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children: [
                          InkWell(
                            onLongPress: ()
                          {
                             setState(() {
                               infoObject.removeData(oldList: retrievedList, index: index);
                               retrievedData();
                             });
                          },
                            onTap: (){
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      "${retrievedList[index][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                  Text(
                                      "₦${retrievedList[index][1]}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                  );
                  }
              ),
                ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                    "₦${
                    infoObject.totalAmountPerDay(retrievedList, retrievedList.length)
                    }",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: Title,
                        decoration: InputDecoration(
                          hintText: "Reason for spending",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: Amount,
                        decoration: InputDecoration(
                          hintText: "Amount spent",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              infoObject.Store(
                  oldList: retrievedList,
                  title: Title.text,
                  amount: int.parse(Amount.text),
              );
              retrievedData();
              Title.clear();
              Amount.clear();
            setState(() {});
          },
            icon: Icon(Icons.add),
            label: Text('Add'),
          ),
    );

  }

}
